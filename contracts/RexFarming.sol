// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./BaseFarming.sol";
import "./RexToken.sol";
import "./Boosting.sol";

interface IReferral {
    function checkReferralQualification(
        address _user
    )
        external
        view
        returns (
            bool _qualification,
            uint256 _referrerReward,
            uint256 _refereeReward
        );
}

contract RexFarming is BaseFarming {
    using SafeERC20 for IERC20;

    address public boosting;

    address public referralSC;

    mapping(address => address) public referrers;

    function configBoosting(
        address _boosting
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        boosting = _boosting;
    }

    function configReferral(
        address _referralSC
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        referralSC = _referralSC;
    }

    // Eight years in total, with half the annual reward.
    function getMultiplier(
        uint256 _from,
        uint256 _to
    ) public view override returns (uint256) {
        uint year = 365 days;
        uint total = 0;
        total +=
            getMultiByTime(_from, _to, startTime, startTime + 1 * year) *
            (2 ** 7);
        total +=
            getMultiByTime(
                _from,
                _to,
                startTime + 1 * year,
                startTime + 2 * year
            ) *
            (2 ** 6);
        total +=
            getMultiByTime(
                _from,
                _to,
                startTime + 2 * year,
                startTime + 3 * year
            ) *
            (2 ** 5);
        total +=
            getMultiByTime(
                _from,
                _to,
                startTime + 3 * year,
                startTime + 4 * year
            ) *
            (2 ** 4);
        total +=
            getMultiByTime(
                _from,
                _to,
                startTime + 4 * year,
                startTime + 5 * year
            ) *
            (2 ** 3);
        total +=
            getMultiByTime(
                _from,
                _to,
                startTime + 5 * year,
                startTime + 6 * year
            ) *
            (2 ** 2);
        total +=
            getMultiByTime(
                _from,
                _to,
                startTime + 6 * year,
                startTime + 7 * year
            ) *
            (2 ** 1);
        total +=
            getMultiByTime(
                _from,
                _to,
                startTime + 7 * year,
                startTime + 8 * year
            ) *
            (2 ** 0);
        return total;
    }

    function pendingReward(
        uint256 _pid,
        address _user
    ) public view override returns (uint256) {
        uint pending = super.pendingReward(_pid, _user);
        if (boosting != address(0)) {
            uint multi = Boosting(boosting).getUserBoosting(_user, _pid);
            return (pending * multi) / 1e12;
        }
        return pending;
    }

    function deposit(
        uint256 _pid,
        uint256 _amount
    ) public override nonReentrant {
        require(_pid < poolInfo.length, "deposit: invalid pid");

        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        updatePool(_pid);
        if (user.amount > 0) {
            uint256 pending = (user.amount * pool.accRewardPerShare) /
                1e12 -
                user.rewardDebt;
            if (boosting != address(0)) {
                uint multi = Boosting(boosting).getUserBoosting(
                    msg.sender,
                    _pid
                );
                pending = (pending * multi) / 1e12;
            }
            safeRewardTransfer(msg.sender, pending);
        }
        if (_amount > 0) {
            pool.lpToken.safeTransferFrom(
                address(msg.sender),
                address(this),
                _amount
            );
            user.amount = user.amount + _amount;
        }
        user.rewardDebt = (user.amount * pool.accRewardPerShare) / 1e12;
        emit Deposit(msg.sender, _pid, _amount);
    }

    // Withdraw LP tokens from WanSwapFarm.
    function withdraw(
        uint256 _pid,
        uint256 _amount
    ) public override nonReentrant {
        require(_pid < poolInfo.length, "withdraw: invalid pid");

        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        updatePool(_pid);
        uint256 pending = (user.amount * pool.accRewardPerShare) /
            1e12 -
            user.rewardDebt;
        if (boosting != address(0)) {
            uint multi = Boosting(boosting).getUserBoosting(msg.sender, _pid);
            pending = (pending * multi) / 1e12;
        }
        user.amount = user.amount - _amount;
        user.rewardDebt = (user.amount * pool.accRewardPerShare) / 1e12;
        safeRewardTransfer(msg.sender, pending);
        pool.lpToken.safeTransfer(address(msg.sender), _amount);
        emit Withdraw(msg.sender, _pid, _amount);
    }

    function getMultiByTime(
        uint256 _from,
        uint256 _to,
        uint256 _start,
        uint256 _end
    ) internal pure returns (uint256) {
        if (_to <= _start) {
            return 0;
        }
        if (_from >= _end) {
            return 0;
        }
        if (_from < _start) {
            _from = _start;
        }
        if (_to > _end) {
            _to = _end;
        }
        return _to - _from;
    }

    function safeRewardTransfer(
        address _to,
        uint256 _amount
    ) internal override {
        RexToken(address(rewardToken)).mint(_to, _amount);
        if (referralSC != address(0) && referrers[_to] != address(0)) {
            (
                bool _qualification,
                uint256 _referrerReward,
                uint256 _refereeReward
            ) = IReferral(referralSC).checkReferralQualification(referrers[_to]);
            if (_qualification) {
                RexToken(address(rewardToken)).mint(
                    referrers[_to],
                    _amount * _referrerReward / 1e18
                );
                RexToken(address(rewardToken)).mint(_to, _amount * _refereeReward / 1e18);
            }
        }
    }

    function depositWithNft(
        uint256 _pid,
        uint256 _amount,
        uint sasId,
        uint zooboosterId,
        address _referrer
    ) external {
        require(boosting != address(0), "Boosting not config");
        deposit(_pid, _amount);
        Boosting(boosting).deposit(msg.sender, _pid, sasId, zooboosterId);
        if (_referrer != address(0) && _referrer != msg.sender && referrers[msg.sender] == address(0)) {
            referrers[msg.sender] = _referrer;
        }
    }

    function withdrawWithNft(uint256 _pid, uint256 _amount) external {
        require(boosting != address(0), "Boosting not config");
        withdraw(_pid, _amount);
        if (_amount > 0) {
            Boosting(boosting).withdraw(msg.sender, _pid);
        }
    }
}
