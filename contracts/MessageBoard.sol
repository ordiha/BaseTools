// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageBoard {
    string[] public messages;

    event MessagePosted(address indexed sender, string message);

    function postMessage(string memory message) public {
        messages.push(message);
        emit MessagePosted(msg.sender, message);
    }

    function getMessage(uint256 index) public view returns (string memory) {
        require(index < messages.length, "Invalid index");
        return messages[index];
    }
}
