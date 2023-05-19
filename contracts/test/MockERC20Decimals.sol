// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MockERC20Decimals is ERC20 {
    uint _decimals;
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals_,
        uint256 mintAmount
    ) ERC20(name, symbol) {
        _decimals = decimals_;
        _mint(msg.sender, mintAmount);
    }

    function decimals() public view override returns (uint8) {
        return uint8(_decimals);
    }
}
