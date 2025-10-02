// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GreetingCard {
    mapping(address => string) public greetings;

    event GreetingSet(address indexed sender, string message);

    function setGreeting(string memory message) public {
        greetings[msg.sender] = message;
        emit GreetingSet(msg.sender, message);
    }

    function getGreeting(address user) public view returns (string memory) {
        return greetings[user];
    }
}
