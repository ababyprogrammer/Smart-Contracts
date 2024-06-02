// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ImmutableExample {
    uint public immutable MY_CONSTANT;

    constructor(uint _valu) {
        MY_CONSTANT = _valu;
    }

    function updateConstant(uint _newValue) external {
        // This will result in a compilation error
        MY_CONSTANT = _newValue;
    }
}
