// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
contract Storage {
    uint public data;

    constructor (uint defaultData) {
        data = defaultData;
    }

    function set(uint newData) public {
        data = newData;
    }
}