// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Event {
    // Event declaration
    // Up to 3 parameters can be indexed.
    // Indexed parameters help you filter the logs by the indexed parameter
    event Log(address indexed sender, string message);
    event AnotherLog();
    function test() public {
        emit Log(msg.sender, "Hello, world!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}