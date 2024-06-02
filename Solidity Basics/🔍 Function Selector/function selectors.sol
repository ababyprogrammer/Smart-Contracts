// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract FunctionSelectors {
    function getSelector(string calldata _func) public pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}