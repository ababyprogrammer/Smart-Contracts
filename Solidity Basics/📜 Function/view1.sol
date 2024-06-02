// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ViewAndPure {
    // … Other contract variables
    // Promise not to modify or read from the state.
    
    function add(uint i, uint j) public pure returns (uint) {
        return i + j;
    }
}