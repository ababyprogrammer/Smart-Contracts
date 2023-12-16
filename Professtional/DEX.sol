// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract DEX is ReentrancyGuard {
    using Address for address payable;

    IERC20 public token;
    uint256 public totalLiquidity;

    event Deposit(address indexed _provider, uint256 _amount, uint256 _time);
    event Withdraw(address indexed _provider, uint256 _amount, uint256 _time);
    event Swap(
        address indexed _from,
        address indexed _to,
        uint256 _fromAmount,
        uint256 _toAmount,
        uint256 _time
    );

    struct Provider {
        uint256 liquidity;
        uint256 withdrawalShare;
    }

    mapping(address => Provider) public providers;

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    function deposit(uint256 _amount) external nonReentrant {
        require(_amount > 0, "Error: Amount should be greater than 0");

        token.transferFrom(msg.sender, address(this), _amount);

        if (providers[msg.sender].liquidity == 0) {
            providers[msg.sender].liquidity = _amount;
            totalLiquidity += _amount;

            emit Deposit(msg.sender, _amount, block.timestamp);
        } else {
            uint256 share = (providers[msg.sender].liquidity * totalLiquidity) /
                providers[msg.sender].withdrawalShare;
            uint256 finalShare = share + _amount;

            providers[msg.sender].liquidity = finalShare;
            totalLiquidity += _amount;

            emit Deposit(msg.sender, _amount, block.timestamp);
        }
    }

    function withdraw(uint256 _amount) external nonReentrant {
        require(_amount > 0, "Error: Amount should be greater than 0");
        require(
            providers[msg.sender].liquidity >= _amount,
            "Error: Insufficient Liquidity"
        );

        uint256 share = (providers[msg.sender].liquidity * totalLiquidity) /
            providers[msg.sender].withdrawalShare;
        uint256 withdrawalShare = (share * _amount) / providers[msg.sender].liquidity;

        providers[msg.sender].withdrawalShare += withdrawalShare;
        providers[msg.sender].liquidity -= _amount;
        totalLiquidity -= _amount;

        token.transfer(msg.sender, _amount);

        emit Withdraw(msg.sender, _amount, block.timestamp);
    }

    function swap(
        address _from,
        address _to,
        uint256 _amount
    ) external nonReentrant {
        require(_amount > 0, "Error: Amount should be greater than 0");
        require(_from != _to, "Error: Tokens should be different");

        uint256 toAmount = getAmountOut(_from, _to, _amount);

        token.transferFrom(_from, _to, toAmount);

        emit Swap(_from, _to, _amount, toAmount, block.timestamp);
    }

    function getAmountOut(
        address _from,
        address _to,
        uint256 _amount
    ) public view returns (uint256) {
        uint256 fromBalance = token.balanceOf(_from);
        uint256 toBalance = token.balanceOf(_to);

        return (_amount * (toBalance)) / fromBalance;
    }
}