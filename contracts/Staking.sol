// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "hardhat/console.sol";

interface IWWAN {
    function deposit() external payable;
    function withdraw(uint) external;
}

contract Staking is Initializable, AccessControl {
    using SafeERC20 for IERC20;

    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR");

    struct UserInfo {
        uint256 amount;     
        uint256 rewardDebt; 
    }

    // Info of each pool.
    struct PoolInfo {
        IERC20  lpToken;          // Address of LP token contract.
        IERC20  rewardToken;      // token address for reward

        uint256 currentSupply;   //
        uint256 bonusStartTimestamp;  //
        uint256 bonusEndTimestamp;    // Block number when bonus period ends.

        uint256 lastRewardTimestamp;  // Last block number that reward distribution occurs.
        uint256 accRewardPerShare;// Accumulated reward per share, times 1e12 or 1e32. See below.
        uint256 rewardPerSecond;   // tokens reward per block.
    }

    IWWAN public wwan;            // The WWAN contract
    PoolInfo[] public poolInfo;   // Info of each pool.
    mapping (uint256 => mapping (address => UserInfo)) public userInfo;// Info of each user that stakes LP tokens.
    
    event Add(uint256 indexed pid, address indexed lpToken, address indexed rewardToken, uint256 startTime, uint256 endTime, uint256 rewardPerSecond);
    event Set(uint256 indexed pid, uint256 endTime, uint256 rewardPerSecond);
    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event EmergencyWithdraw(address indexed user, uint256 indexed pid, uint256 amount);

    modifier onlyOperator() {
        require(hasRole(OPERATOR_ROLE, msg.sender), "not operator");
        _;
    }

    modifier onlyValidPool(uint256 _pid) {
        require(_pid < poolInfo.length,"invalid pid");
        _;
    }

    function initialize(address admin, address operator, IWWAN _wwan)
        external
        initializer
    {
        _setupRole(DEFAULT_ADMIN_ROLE, admin);
        _setupRole(OPERATOR_ROLE, operator);
        wwan = _wwan;
    }

    function add(address _lpToken, address _rewardToken, uint256 _startTime, uint256 _endTime, uint256 _rewardPerSecond)
        external
        onlyOperator
    {
        require(block.timestamp < _endTime, "invalid end time");
        require(_startTime < _endTime, "invalid start time");
        require(_lpToken != address(0), "invalid lp");
        require(_rewardToken != address(0), "invalid reward token");

        poolInfo.push(PoolInfo({
            lpToken: IERC20(_lpToken),
            rewardToken: IERC20(_rewardToken),
            currentSupply: 0,
            bonusStartTimestamp: _startTime,
            bonusEndTimestamp: _endTime,
            lastRewardTimestamp: block.timestamp > _startTime ? block.timestamp : _startTime,
            accRewardPerShare: 0,
            rewardPerSecond: _rewardPerSecond
        }));
        emit Add((poolInfo.length - 1), _lpToken, _rewardToken, _startTime, _endTime, _rewardPerSecond);
    }

    function set(uint256 _pid, uint256 _rewardPerSecond, uint256 _endTime)
        external
        onlyOperator
    {
        updatePool(_pid);
        poolInfo[_pid].rewardPerSecond = _rewardPerSecond;
        poolInfo[_pid].bonusEndTimestamp = _endTime;

        emit Set(_pid, _rewardPerSecond, _endTime);
    }

    function massUpdatePools() public {
        uint256 length = poolInfo.length;
        for (uint256 pid = 0; pid < length; ++pid) {
            updatePool(pid);
        }
    }

    function updatePool(uint256 _pid) public {
        PoolInfo storage pool = poolInfo[_pid];
        if (block.timestamp <= pool.lastRewardTimestamp) {
            return;
        }

        if (pool.currentSupply == 0) {
            pool.lastRewardTimestamp = block.timestamp;
            return;
        }

        uint256 multiplier = getMultiplier(pool.lastRewardTimestamp, block.timestamp, pool.bonusStartTimestamp, pool.bonusEndTimestamp);
        uint256 tokenReward = multiplier * pool.rewardPerSecond;
        pool.accRewardPerShare = pool.accRewardPerShare + (tokenReward * 1e32 / pool.currentSupply);
        pool.lastRewardTimestamp = block.timestamp;
    }

    function deposit(uint256 _pid, uint256 _amount) external onlyValidPool(_pid) {
        PoolInfo storage pool = poolInfo[_pid];

        updatePool(_pid);

        UserInfo storage user = userInfo[_pid][msg.sender];

        uint256 pending = user.amount * pool.accRewardPerShare / 1e32 - user.rewardDebt;

        pool.lpToken.safeTransferFrom(address(msg.sender), address(this), _amount);

        user.amount = user.amount + _amount;
        pool.currentSupply = pool.currentSupply + _amount;
        user.rewardDebt = user.amount * pool.accRewardPerShare / 1e32;

        if(pending > 0) {
            if (address(pool.rewardToken) == address(wwan)) { // convert wwan to wan 
                wwan.withdraw(pending);
                payable(msg.sender).transfer(pending);
            } else {
                pool.rewardToken.safeTransfer(msg.sender, pending);
            }
        }
        emit Deposit(msg.sender, _pid, _amount);
    }

    function withdraw(uint256 _pid, uint256 _amount) external onlyValidPool(_pid) {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];

        updatePool(_pid);
        uint256 pending = user.amount * pool.accRewardPerShare / 1e32 - user.rewardDebt;

        if(_amount > 0) {
            user.amount = user.amount - _amount;
            pool.currentSupply = pool.currentSupply - _amount;
        }
        user.rewardDebt = user.amount * pool.accRewardPerShare / 1e32;

        if (_amount > 0) {
            pool.lpToken.safeTransfer(msg.sender, _amount);
        }
        if(pending > 0) {
            if (address(pool.rewardToken) == address(wwan)) {
                wwan.withdraw(pending);
                payable(msg.sender).transfer(pending);
            } else {
                pool.rewardToken.safeTransfer(msg.sender, pending);
            }
        }
        emit Withdraw(msg.sender, _pid, _amount);
    }

    function emergencyWithdraw(uint256 _pid) external onlyValidPool(_pid) {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        uint256 amount = user.amount;
        if(amount > 0){
            pool.currentSupply = pool.currentSupply - user.amount;
            user.amount = 0;
            user.rewardDebt = 0;
            pool.lpToken.safeTransfer(msg.sender, amount);
        }
        emit EmergencyWithdraw(msg.sender, _pid, amount);
    }

    receive() external payable {
        require(msg.sender == address(wwan), "Only support value from WWAN");
    }

    function getMultiplier(uint256 _from, uint256 _to, uint256 _startTime, uint256 _endTime) internal pure returns (uint256) {
        if (_from >= _endTime) {
            return 0;
        }

        if (_to < _startTime) {
            return 0;
        }

        if (_from < _startTime) {
            _from = _startTime;
        }

        if (_to > _endTime) {
            _to = _endTime;
        }
        return _to - _from;
    }

    function poolLength() external view returns (uint256) {
        return poolInfo.length;
    }

    function pendingReward(uint256 _pid, address _user) external view onlyValidPool(_pid) returns (uint256) {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][_user];
        uint256 accRewardPerShare = pool.accRewardPerShare;

        if (block.timestamp > pool.lastRewardTimestamp && pool.currentSupply != 0) {
            uint256 multiplier = getMultiplier(pool.lastRewardTimestamp, block.timestamp, pool.bonusStartTimestamp, pool.bonusEndTimestamp);
            uint256 tokenReward = multiplier * pool.rewardPerSecond;
            accRewardPerShare = accRewardPerShare + (tokenReward * 1e32 / pool.currentSupply);
        }
        return user.amount * accRewardPerShare / 1e32 - user.rewardDebt;
    }
}
