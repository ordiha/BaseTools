// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProfileBadge {
    mapping(address => string) public badges;

    event BadgeAssigned(address indexed user, string badge);

    function assignBadge(string memory badge) public {
        badges[msg.sender] = badge;
        emit BadgeAssigned(msg.sender, badge);
    }

    function getBadge(address user) public view returns (string memory) {
        return badges[user];
    }
}
