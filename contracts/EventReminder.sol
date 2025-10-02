// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventReminder {
    struct Reminder {
        string eventName;
        uint256 timestamp;
    }
    mapping(address => Reminder[]) public reminders;

    event ReminderSet(address indexed user, string eventName, uint256 timestamp);

    function setReminder(string memory eventName, uint256 timestamp) public {
        reminders[msg.sender].push(Reminder(eventName, timestamp));
        emit ReminderSet(msg.sender, eventName, timestamp);
    }

    function getReminders(address user) public view returns (Reminder[] memory) {
        return reminders[user];
    }
}
