// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenTracker {
    mapping(address => uint256) public balances;

    event BalanceUpdated(address indexed user, uint256 amount);

    function updateBalance(address user, uint256 amount) public {
        balances[user] = amount;
        emit BalanceUpdated(user, amount);
    }

    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
}
