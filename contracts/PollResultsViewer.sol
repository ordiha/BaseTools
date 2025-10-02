// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollResultsViewer {
    mapping(uint256 => uint256) public results;
    uint256 public optionCount;

    event ResultUpdated(uint256 option, uint256 count);

    constructor(uint256 _optionCount) {
        optionCount = _optionCount;
    }

    function updateResult(uint256 option, uint256 count) public {
        require(option < optionCount, "Invalid option");
        results[option] = count;
        emit ResultUpdated(option, count);
    }

    function getResult(uint256 option) public view returns (uint256) {
        return results[option];
    }
}
