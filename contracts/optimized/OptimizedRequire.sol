// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedRequire {
    uint256 constant COOLDOWN = 1 minutes;
    uint256 timestampThreshold = COOLDOWN;

    function purchaseToken() external payable {
        require(
            msg.value == 0.1 ether &&
                block.timestamp > timestampThreshold,
            "cannot purchase"
        );
        timestampThreshold = block.timestamp + COOLDOWN;
        // mint the user a token
    }
}
