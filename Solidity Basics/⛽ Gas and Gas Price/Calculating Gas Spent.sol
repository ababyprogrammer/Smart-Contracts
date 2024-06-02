// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract GasExample {
    function calculateGas() public pure returns (uint) {
        uint startGas = gasleft();
        // Perform computations or operations
        uint endGas = gasleft();
        return startGas - endGas;
    }
}