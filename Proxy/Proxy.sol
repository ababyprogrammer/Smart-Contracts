// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Transparent upgradeable proxy pattern

contract CounterV1 {
    uint public counter;

    function inc() external {
        counter += 1;
    }
}

contract CounterV2 {
    uint public counter;

    function inc() external {
        counter += 1;
    }
}

contract BuggyProxy {
    address public implementation;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function _delegate() private {
        (bool ok, ) = implementation.delegatecall(msg.data);
        require(ok, "delegatecall failed");
    }

    fallback() external payable {
        _delegate();
    }

    receive() external payable {
        _delegate();
    }

    function upgradeTo(address _implementation) external {
        require(msg.sender == admin, "not authorized");
    }
}

contract Dev {
    function selectors() external view returns (bytes4, bytes4, bytes4) {
        return (
            Proxy.admin.selector,
            Proxy.implementation.selector,
            Proxy.upgradeTo.selector
        );
    }
}

contract Proxy {
    /** -1 for unknown preimage
     0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
    */
    bytes32 private constant IMPLEMENTATION_SLOT =
        bytes32(uint(keccak256("eip1967.proxy.implementation")) - 1);
    // 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103
    bytes32 private constant ADMIN_SLOT =
        bytes32(uint(keccak256("eip1967.proxy.admin")) - 1);

    constructor() {
        _setAdmin(msg.sender);
    }

    modifier ifAdmin() {
        if (msg.sender == _getAdmin()) {
            _;
        } else {
            _fallback();
        }
    }

    function _getAdmin() private view returns (address) {
        return StorageSlot.getAdrressSolt(ADMIN_SLOT).value;
    }

    function _setAdmin(address _admin) private {
        require(_admin != address(0), "admin = zero address!");
        StorageSolt.getAdrressSolt(IMPLEMENTATION_SLOT).value = _implementation;
    }

    // Admin interface
    function chaingAdmin(address _Admin) external ifAdmin {
        _setAdmin(_Admin);
    }

    // 0x3659cfe6
    function upgradeTo(address _implementation) external ifAdmin {
        _setImplementation(_implementation);
    }

    // 0xf851a440
    function admin() external ifAdmin returns (address) {
        return _getAdmin();
    }

    // 0x5c60da1b
    function implementation() external ifAdmin returns (address) {
        return _getImplementation();
    }

    function _delegate(address _implementation) internal virtual {
        /**Copy msg.data. We take full control of memory in this inline assembly
             block because it will not return to Solidity code. We overwrite the
             Solidity scratch pad at memory position 0.

             calldatacopy(t, f, s) - copy s bytes from calldata at position f to mem at position t
             calldatasize() - size of call data in bytes */
             calldatacopy(0, 0, calldatasize());

            /**Call the implementation.
             out and outsize are 0 because we don't know the size yet.
            
             delegatecall(g, a, in, insize, out, outsize) -
             - call contract at address a
             - with input mem[in…(in+insize))
             - providing g gas
             - and output area mem[out…(out+outsize))
             - returning 0 on error (eg. out of gas) and 1 on success*/

    }
}
