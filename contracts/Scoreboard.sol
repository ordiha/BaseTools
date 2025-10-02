// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Scoreboard {
    mapping(address => uint256) public scores;

    event ScoreUpdated(address indexed player, uint256 score);

    function updateScore(uint256 score) public {
        scores[msg.sender] = score;
        emit ScoreUpdated(msg.sender, score);
    }

    function getScore(address player) public view returns (uint256) {
        return scores[player];
    }
}
