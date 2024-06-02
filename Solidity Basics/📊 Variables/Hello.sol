// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Variables {
    string public text = "Hello";
    uint public num = 123;

    function doSomething() public {
        uint i = 456;
        uint timestamp = block.timestamp;
        address sender = msg.sender;
        // Rest of the function code...
    }
}
