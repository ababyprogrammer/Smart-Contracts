// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Escrow {
    address payable public seller;
    address payable public buyer;
    uint public value;
    bool public dispute;

    constructor (address payable _seller, address payable _buyer, uint _value) public {
        seller = _seller;
        buyer = _buyer;
        value = _value;
    }

    function releaseFundsToSeller() public {
        require(msg.sender == seller, "Only the seller can release funds!");
        require(!dispute, "There is an ongoing dispute.");
        seller.transfer(value);
    }

    function releaseFundsToBuyer() public {
        require(msg.sender == buyer, "Only the buyer can release funds!");
        require(!dispute, "There is an ongoing dispute.");
        buyer.transfer(value);
    }

    function disputeFunds() public {
        require(msg.sender == buyer, "Only the buyer can release funds!");
        dispute = true;
    }

    function resolveDispute(address payable _recipient) public {
        require(msg.sender == seller, "Only the seller can resolve a dispute.");
        require(dispute, "There is no ongoing dispute.");
        _recipient.transfer(value);
        dispute = false;
    }
}