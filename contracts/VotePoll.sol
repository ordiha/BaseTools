// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotePoll {
    mapping(uint256 => uint256) public votes;
    uint256 public optionCount;

    event Voted(address indexed voter, uint256 option);

    constructor(uint256 _optionCount) {
        optionCount = _optionCount;
    }

    function vote(uint256 option) public {
        require(option < optionCount, "Invalid option");
        votes[option]++;
        emit Voted(msg.sender, option);
    }

    function getVotes(uint256 option) public view returns (uint256) {
        return votes[option];
    }
}
