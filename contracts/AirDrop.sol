// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// only the NFT holder could claim the reward token
contract AirDrop is Initializable, AccessControl, ReentrancyGuard {
    using SafeERC20 for IERC20;

    address public rewardToken;
    address public nftAddr;

    uint public initialRewardPerNFT;
    uint public vestRewardPerNFT;
    uint public startTime;
    uint public endTime;

    mapping(uint => bool) initialClaim;
    mapping(uint => uint) nftClaimed;

    modifier isNFTHolder(uint nftId) {
        require(IERC721(nftAddr).ownerOf(nftId) == msg.sender, "not nft holder");
        _;
    }

    event Claim(address indexed user, uint nftId, uint amount);

    function initialize(address admin, address rewardToken_, address nftAddr_, uint initialRewardPerNFT_, uint vestRewardPerNFT_, uint startTime_, uint endTime_) external initializer {
        _setupRole(DEFAULT_ADMIN_ROLE, admin);
        rewardToken = rewardToken_;
        nftAddr = nftAddr_;
        initialRewardPerNFT = initialRewardPerNFT_;
        vestRewardPerNFT = vestRewardPerNFT_;
        startTime = startTime_;
        endTime = endTime_;
    }

    function claim(uint nftId) external nonReentrant isNFTHolder(nftId) {
        uint pending = pendingReward(nftId);

        nftClaimed[nftId] += pending;

        IERC20(rewardToken).safeTransfer(msg.sender, pending);
        emit Claim(msg.sender, nftId, pending);
    }

    function pendingReward(uint nftId) public view returns (uint) {
        if (block.timestamp < startTime) {
            return 0;
        }
        uint vested = vestedAmountPerNFT();
        return vested + initialRewardPerNFT - nftClaimed[nftId];
    }

    function vestedAmountPerNFT() internal view returns (uint) {
        uint calcTime = block.timestamp;
        if (calcTime >= endTime) {
            calcTime = endTime;
        }

        return vestRewardPerNFT * (calcTime - startTime) / (endTime - startTime);
    }

    function withdraw() external onlyRole(DEFAULT_ADMIN_ROLE) {
        IERC20(rewardToken).safeTransfer(msg.sender, IERC20(rewardToken).balanceOf(address(this)));
    }
}
