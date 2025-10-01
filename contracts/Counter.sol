// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint256 public count;

    event Incremented(uint256 newCount);

    function increment() public {
        count++;
        emit Incremented(count);
    }

    function getCount() public view returns (uint256) {
        return count;
    }
}
