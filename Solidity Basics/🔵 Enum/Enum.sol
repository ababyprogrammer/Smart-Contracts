// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Enum {
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }
    Status public status;
    function get() view public returns (Status) {
        return status;
    }

    function set(Status _status) public {
        status = _status;
    }

    function cancle() public {
        status = Status.Canceled;
    }

    function reset() public {
        delete status;
    }
}