// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ViewAndPure {
    uint public x = 1;
    // Promise not to modify the state.
    function addToX(uint y) public view returns (uint) {
        return x + y;
    }
    
    // … Other functions
}