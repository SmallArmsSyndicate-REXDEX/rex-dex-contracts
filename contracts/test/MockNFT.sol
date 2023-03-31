// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MockNFT is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    mapping(uint => string) private _tokenURIs;

    constructor() ERC721("MockNFT", "MFT") {}

    function _baseURI() internal pure override returns (string memory) {
        return "";
    }

    function safeMint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);
        return _tokenURIs[tokenId];
    }

    function safeMintWithURI(uint tokenId, string calldata URI) public {
        _safeMint(msg.sender, tokenId);
        _tokenURIs[tokenId] = URI;
    }

    // mock for zoobooster
    function getBoosting(uint256 /*_tokenId*/) external pure returns (uint256) {
        return 1e12 + 1e11; // mock 110%
    }
}

