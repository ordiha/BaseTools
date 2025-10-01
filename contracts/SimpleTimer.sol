// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleTimer {
    uint256 public startTime;
    uint256 public duration;

    event TimerStarted(uint256 startTime, uint256 duration);

    constructor(uint256 _duration) {
        duration = _duration;
    }

    function startTimer() public {
        startTime = block.timestamp;
        emit TimerStarted(startTime, duration);
    }

    function timeLeft() public view returns (uint256) {
        if (startTime == 0) return duration;
        uint256 elapsed = block.timestamp - startTime;
        return elapsed < duration ? duration - elapsed : 0;
    }
}
