// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageUnit {
    mapping(address => uint256) public storedValues;

    event ValueStored(address indexed user, uint256 value);

    function store(uint256 value) public {
        storedValues[msg.sender] = value;
        emit ValueStored(msg.sender, value);
    }

    function retrieve() public view returns (uint256) {
        return storedValues[msg.sender];
    }
}
