// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GiveawayBox {
    address public owner;
    address[] public participants;

    event Entered(address indexed participant);

    constructor() {
        owner = msg.sender;
    }

    function enter() public {
        participants.push(msg.sender);
        emit Entered(msg.sender);
    }

    function pickWinner(uint256 index) public view returns (address) {
        require(msg.sender == owner, "Only owner can pick winner");
        require(index < participants.length, "Invalid index");
        return participants[index];
    }
}
