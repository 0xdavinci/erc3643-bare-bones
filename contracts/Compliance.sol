// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IdentityRegistry.sol";

contract Compliance {
    IdentityRegistry public registry;

    constructor(address _registry) {
        registry = IdentityRegistry(_registry);
    }

    function canTransfer(
        address from,
        address to
    ) external view returns (bool) {
        return registry.isVerified(from) && registry.isVerified(to);
    }
}
