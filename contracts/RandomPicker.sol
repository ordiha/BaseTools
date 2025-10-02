// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RandomPicker {
    address[] public entries;

    event Picked(address indexed winner);

    function enter() public {
        entries.push(msg.sender);
    }

    function pickRandom(uint256 seed) public view returns (address) {
        require(entries.length > 0, "No entries");
        uint256 index = uint256(keccak256(abi.encodePacked(block.timestamp, seed))) % entries.length;
        return entries[index];
    }
}
