// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    // State variables
    uint256 public myVariable;
    address public owner;

    // Events
    event ValueChanged(uint256 newValue);

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    // Functions
    function setValue(uint256 newValue) public onlyOwner {
        require(newValue != myVariable, "The new value must be different from the current value");

        myVariable = newValue;
        emit ValueChanged(newValue);
    }

    function getValue() public view returns (uint256) {
        return myVariable;
    }
}
