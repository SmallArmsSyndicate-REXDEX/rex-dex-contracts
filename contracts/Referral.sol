// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Referral is AccessControl, ERC721Holder, Initializable, ReentrancyGuard {
    IERC20 public rexToken;
    IERC721 public sasNFT;
    uint256 public requiredRexTokens;

    // Referrer and referee reward percentages
    uint256 public referrerRewardPercentage; // scale to 100% = 1e18
    uint256 public refereeRewardPercentage;  // scale to 100% = 1e18

    // User staking information
    mapping(address => uint256) public userNFTs;
    mapping(address => bool) public hasReferralQualification;
    mapping(address => uint256) public userStakedRexTokens;

    // Events
    event Staked(address indexed user, uint256 tokenId);
    event Withdrawn(address indexed user, uint256 tokenId);
    event RequiredRexTokensUpdated(uint256 newAmount);
    event RewardPercentagesUpdated(
        uint256 newReferrerReward,
        uint256 newRefereeReward
    );

    // Initialize contract
    function initialize(
        address _rexToken,
        address _sasNFT,
        uint256 _requiredRexTokens,
        uint256 _referrerRewardPercentage, // scale 1e18
        uint256 _refereeRewardPercentage   // scale 1e18
    ) public initializer {
        require(
            _requiredRexTokens > 0,
            "Required RexToken amount should be greater than 0"
        );

        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());

        rexToken = IERC20(_rexToken);
        sasNFT = IERC721(_sasNFT);
        requiredRexTokens = _requiredRexTokens;
        referrerRewardPercentage = _referrerRewardPercentage;
        refereeRewardPercentage = _refereeRewardPercentage;
    }

    // Users stake RexToken and SAS NFT
    function stake(uint256 _tokenId) external nonReentrant {
        require(
            rexToken.balanceOf(msg.sender) >= requiredRexTokens,
            "Not enough RexTokens to stake"
        );
        require(
            sasNFT.ownerOf(_tokenId) == msg.sender,
            "Not the owner of the SAS NFT"
        );
        require(!hasReferralQualification[msg.sender], "Already staked");

        rexToken.transferFrom(msg.sender, address(this), requiredRexTokens);
        sasNFT.safeTransferFrom(msg.sender, address(this), _tokenId);

        userNFTs[msg.sender] = _tokenId;
        userStakedRexTokens[msg.sender] = requiredRexTokens;
        hasReferralQualification[msg.sender] = true;

        emit Staked(msg.sender, _tokenId);
    }

    // Users withdraw staked tokens
    function withdraw() external nonReentrant {
        require(
            hasReferralQualification[msg.sender],
            "No staked tokens to withdraw"
        );

        uint256 _tokenId = userNFTs[msg.sender];

        uint256 stakedRexTokens = userStakedRexTokens[msg.sender];
        userStakedRexTokens[msg.sender] = 0;
        
        userNFTs[msg.sender] = 0;
        hasReferralQualification[msg.sender] = false;

        rexToken.transfer(msg.sender, stakedRexTokens);
        sasNFT.safeTransferFrom(address(this), msg.sender, _tokenId);

        emit Withdrawn(msg.sender, _tokenId);
    }

    // Check user referral qualification and reward percentages
    function checkReferralQualification(
        address _user
    )
        external
        view
        returns (
            bool _qualification,
            uint256 _referrerReward,
            uint256 _refereeReward
        )
    {
        _qualification = hasReferralQualification[_user];
        _referrerReward = referrerRewardPercentage;
        _refereeReward = refereeRewardPercentage;
    }

    // Update required RexToken amount
    function updateRequiredRexTokens(
        uint256 _newAmount
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(_newAmount > 0, "New amount should be greater than 0");
        requiredRexTokens = _newAmount;
        emit RequiredRexTokensUpdated(_newAmount);
    }

    // Update referral reward percentages
    function updateRewardPercentages(
        uint256 _newReferrerReward,
        uint256 _newRefereeReward
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        referrerRewardPercentage = _newReferrerReward;
        refereeRewardPercentage = _newRefereeReward;
        emit RewardPercentagesUpdated(_newReferrerReward, _newRefereeReward);
    }
}
