// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract FunctionModifier {
    address public owner;
    uint public x = 10;
    bool public locked;
    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    // Rest of the contract…
}