// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GasPriceExample {
    uint public gasPrice;
    function setGasPrice(uint _gasPrice) public {
    require(_gasPrice > 0, "Gas price must be greater than zero"); 
    gasPrice = _gasPrice;
 }
}