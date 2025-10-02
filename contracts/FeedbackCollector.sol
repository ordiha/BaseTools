// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FeedbackCollector {
    struct Feedback {
        address sender;
        string message;
    }
    Feedback[] public feedbackList;

    event FeedbackReceived(address indexed sender, string message);

    function submitFeedback(string memory message) public {
        feedbackList.push(Feedback(msg.sender, message));
        emit FeedbackReceived(msg.sender, message);
    }

    function getFeedback(uint256 index) public view returns (address, string memory) {
        require(index < feedbackList.length, "Invalid index");
        Feedback memory fb = feedbackList[index];
        return (fb.sender, fb.message);
    }
}
