// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

interface IZooBooster {
    // scale: 1e12
    function getBoosting(uint256 _tokenId) external view returns (uint256);
}

interface IComboBoosting {
    function getCombo2(Boosting.SASInfo calldata info) external pure returns (uint);
    function getCombo3(Boosting.SASInfo calldata info) external pure returns (uint);
    function getCombo4(Boosting.SASInfo calldata info) external pure returns (uint);
    function getCombo6(Boosting.SASInfo calldata info) external pure returns (uint);
}

contract Boosting is Initializable, AccessControl, ERC721Holder, ReentrancyGuard {
    struct UserInfo {
        uint256 sasId;
        uint256 zooboosterId;
    }

    struct SASInfo {
        string background;
        string skins;
        string mouths;
        string eyes;
        string clothes;
        string accessories;
        string head;
    }

    address public sasNft;
    address public zooboosterNft;
    address public farming;

    // user address => pid => UserInfo
    mapping(address => mapping(uint => UserInfo)) public userInfo;

    // tokenId => SASInfo
    mapping(uint => SASInfo) public sasInfo;

    // type => asset name => supply amount
    mapping(string => mapping(string => uint)) public assetSupply;

    address public comboBoosting;

    event Deposit(address indexed user, uint256 indexed pid, uint256 sasId, uint256 zooboosterId);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 sasId, uint256 zooboosterId);

    function initialize(address _farming, address _sasNft, address _zooboosterNft) external initializer {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        farming = _farming;
        sasNft = _sasNft;
        zooboosterNft = _zooboosterNft;
    }

    function injectSasInfo(
        uint[] calldata tokenIds, 
        SASInfo[] memory infos
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        uint length = tokenIds.length;
        for (uint i = 0; i < length; i++) {
            sasInfo[tokenIds[i]] = infos[i];
            assetSupply["background"][infos[i].background] += 1;
            assetSupply["skins"][infos[i].skins] += 1;
            assetSupply["mouths"][infos[i].mouths] += 1;
            assetSupply["eyes"][infos[i].eyes] += 1;
            assetSupply["clothes"][infos[i].clothes] += 1;
            assetSupply["accessories"][infos[i].accessories] += 1;
            assetSupply["head"][infos[i].head] += 1;
        }
    }

    function configComboBoosting(address _comboBoosting) external onlyRole(DEFAULT_ADMIN_ROLE) {
        comboBoosting = _comboBoosting;
    }

    // return value 100% = 1e12
    function getSasBoosting(uint tokenId) public view returns (uint) {
        if (tokenId == 0 || sasNft == address(0)) {
            return 1e12;
        }

        SASInfo storage info = sasInfo[tokenId];
        uint total = 0;
        total += getBoostScoreBySupply("background", info.background);
        total += getBoostScoreBySupply("skins", info.skins);
        total += getBoostScoreBySupply("mouths", info.mouths);
        total += getBoostScoreBySupply("eyes", info.eyes);
        total += getBoostScoreBySupply("clothes", info.clothes);
        total += getBoostScoreBySupply("accessories", info.accessories);
        total += getBoostScoreBySupply("head", info.head);
        total += getComboBoost(tokenId);
        
        return 1e12 + total; // 100% + boost%
    }

    // return value 100% = 1e12
    function getBoostScoreBySupply(string memory types, string memory asset) public view returns(uint) {
        if (keccak256(abi.encodePacked(asset)) == keccak256(abi.encodePacked(""))) {
            return 0;
        }

        uint supply = assetSupply[types][asset];

        if (supply == 0) {
            return 0;
        }
        if (supply <= 10) {
            return 1e12 * 20 / 100;  // 20%
        }
        if (supply <= 30) {
            return 1e12 * 10 / 100;  // 10%
        }
        if (supply <= 59) {
            return 1e12 * 8 / 100;   // 8%
        }
        if (supply <= 99) {
            return 1e12 * 7 / 100;   // 7%
        }
        if (supply <= 199) {
            return 1e12 * 6 / 100;   // 6%
        }
        if (supply <= 299) {
            return 1e12 * 5 / 100;   // 5%
        }
        if (supply <= 399) {
            return 1e12 * 4 / 100;   // 4%
        }
        if (supply <= 499) {
            return 1e12 * 3 / 100;   // 3%
        }
        if (supply <= 999) {
            return 1e12 * 2 / 100;   // 2%
        }
        
        return 1e12 * 1 / 100;       // 1%
    }

    function getComboBoost(uint tokenId) public view returns (uint) {
        if (tokenId == 0 || sasNft == address(0) || comboBoosting == address(0)) {
            return 0;
        }

        SASInfo memory info = sasInfo[tokenId];
        uint total = 0;
        total += IComboBoosting(comboBoosting).getCombo6(info);
        if (total == 0) {
            total += IComboBoosting(comboBoosting).getCombo4(info);
        }
        if (total == 0) {
            total += IComboBoosting(comboBoosting).getCombo3(info);
        }
        if (total == 0) {
            total += IComboBoosting(comboBoosting).getCombo2(info);
        }

        return total;
    }

    // use 30% of zooNft boosting
    function getZooBoosting(uint tokenId) public view returns (uint) {
        if (tokenId == 0 || zooboosterNft == address(0)) {
            return 1e12;
        }

        IZooBooster zoobooster = IZooBooster(zooboosterNft);
        return (zoobooster.getBoosting(tokenId) - 1e12) * 30 / 100 + 1e12;
    }

    function getUserBoosting(address user, uint pid) external view returns (uint) {
        UserInfo memory info = userInfo[user][pid];
        uint sasBoosting = getSasBoosting(info.sasId) - 1e12;
        uint zooBoosting = getZooBoosting(info.zooboosterId) - 1e12;
        return 1e12 + sasBoosting + zooBoosting;
    }

    function deposit(address user, uint pid, uint sasId, uint zooboosterId) external nonReentrant {
        require(msg.sender == farming, "only farming contract can call this function");
        if (sasId != 0) {
            IERC721(sasNft).safeTransferFrom(user, address(this), sasId);
            if (userInfo[user][pid].sasId != 0) {
                IERC721(sasNft).safeTransferFrom(address(this), user, userInfo[user][pid].sasId);
            }
            userInfo[user][pid].sasId = sasId;
        }
        
        if (zooboosterId != 0) {
            IERC721(zooboosterNft).safeTransferFrom(user, address(this), zooboosterId);
            if (userInfo[user][pid].zooboosterId != 0) {
                IERC721(zooboosterNft).safeTransferFrom(address(this), user, userInfo[user][pid].zooboosterId);
            }
            userInfo[user][pid].zooboosterId = zooboosterId;
        }

        emit Deposit(user, pid, sasId, zooboosterId);
    }

    function withdraw(address user, uint pid) external nonReentrant {
        require(msg.sender == farming, "only farming contract can call this function");
        UserInfo storage info = userInfo[user][pid];

        if (info.sasId != 0) {
            if(IERC721(sasNft).ownerOf(info.sasId) == address(this)) {
                IERC721(sasNft).safeTransferFrom(address(this), user, info.sasId);
            }
            info.sasId = 0;
        }

        if (info.zooboosterId != 0) {
            if(IERC721(zooboosterNft).ownerOf(info.zooboosterId) == address(this)) {
                IERC721(zooboosterNft).safeTransferFrom(address(this), user, info.zooboosterId);
            }
            info.zooboosterId = 0;
        }
        
        emit Withdraw(user, pid, info.sasId, info.zooboosterId);
    }
}
