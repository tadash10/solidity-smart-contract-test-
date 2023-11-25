// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    // State variables
    uint256 private myVariable;
    address private owner;

    // Events
    event ValueChanged(address indexed owner, uint256 indexed newValue);

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    // Functions
    function setValue(uint256 newValue) external onlyOwner {
        require(newValue != myVariable, "New value must be different");
        
        myVariable = newValue;
        emit ValueChanged(msg.sender, newValue);
    }

    function getValue() external view returns (uint256) {
        return myVariable;
    }

    // Function to get the contract owner
    function getOwner() external view returns (address) {
        return owner;
    }

    // Function to transfer ownership to a new address
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid new owner address");
        require(newOwner != owner, "New owner is the same as the current owner");

        owner = newOwner;
    }

    // Function to withdraw accidentally sent Ether
    function withdrawEther() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    // Fallback function to reject any Ether sent to the contract
    receive() external payable {
        revert("Contract does not accept Ether");
    }
}
