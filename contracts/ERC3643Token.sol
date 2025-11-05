// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Compliance.sol";

contract ERC3643 is ERC20 {
    Compliance public compliance;

    address public admin;

    constructor(address _compliance) ERC20("RegulatedAssetToken", "RAT") {
        compliance = Compliance(_compliance);
        admin = msg.sender;
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == admin, "Only admin");
        require(compliance.canTransfer(msg.sender, to), "Not verified");
        _mint(to, amount);
    }

    function _update(
        address from,
        address to,
        uint256 amount
    ) internal override {
        if (from != address(0) && to != address(0)) {
            require(compliance.canTransfer(from, to), "Transfer blocked");
        }
        super._update(from, to, amount);
    }
}
