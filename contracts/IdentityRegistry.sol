// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract IdentityRegistry {
    mapping(address => bool) public isVerified;

    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function addVerified(address user) external {
        require(msg.sender == admin, "Only admin");
        isVerified[user] = true;
    }

    function removeVerified(address user) external {
        require(msg.sender == admin, "Only admin");
        isVerified[user] = false;
    }
}
