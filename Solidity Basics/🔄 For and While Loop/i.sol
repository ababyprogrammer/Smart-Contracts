// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Loop {
    function loop() public pure {
        // for loop
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                // Skip to next iteration with continue
                continue;
            }
            if (i == 5) {
                // Exit loop with break
                break;
            }
            // Code block executed for each iteration
        }
    }
}