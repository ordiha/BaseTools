// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FeedbackBox {
    string[] public feedback;

    event FeedbackSubmitted(address indexed sender, string message);

    function submitFeedback(string memory message) public {
        feedback.push(message);
        emit FeedbackSubmitted(msg.sender, message);
    }

    function getFeedback(uint256 index) public view returns (string memory) {
        require(index < feedback.length, "Invalid index");
        return feedback[index];
    }
}
