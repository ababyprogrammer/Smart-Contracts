// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Callee {
    uint public x;
    uint public value;

    function setX(uint _x) public returns (uint) {
        x = _x;
        return x;
    }
    // Additional functions for illustration purposes.
    // ...
}

contract Caller {
    function setX(Callee _callee, uint _x) public {
        uint x = _callee.setX(_x);
    }
}