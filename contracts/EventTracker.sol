// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventTracker {
    struct Event {
        string name;
        uint256 timestamp;
    }
    Event[] public events;

    event EventLogged(string name, uint256 timestamp);

    function logEvent(string memory name) public {
        events.push(Event(name, block.timestamp));
        emit EventLogged(name, block.timestamp);
    }

    function getEvent(uint256 index) public view returns (string memory, uint256) {
        require(index < events.length, "Invalid index");
        Event memory evt = events[index];
        return (evt.name, evt.timestamp);
    }
}
