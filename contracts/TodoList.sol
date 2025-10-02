// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    struct Task {
        string description;
        bool completed;
    }
    Task[] public tasks;

    event TaskAdded(uint256 index, string description);

    function addTask(string memory description) public {
        tasks.push(Task(description, false));
        emit TaskAdded(tasks.length - 1, description);
    }

    function completeTask(uint256 index) public {
        require(index < tasks.length, "Invalid index");
        tasks[index].completed = true;
    }
}
