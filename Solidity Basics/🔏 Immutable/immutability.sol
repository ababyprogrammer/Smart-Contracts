// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Immutable {
    address public immutable MY_ADDRESS;
    uint public immutable MY_UITN;

    constructor(uint _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UITN = _myUint;
    }
}
