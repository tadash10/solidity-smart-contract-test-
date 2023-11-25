// MembershipContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MembershipContract {
    address public owner;
    mapping(address => bool) public members;

    event MemberAdded(address member);
    event MemberRemoved(address member);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function addMember(address member) external onlyOwner {
        require(member != address(0), "Invalid member address");
        require(!members[member], "Member already exists");
        
        members[member] = true;
        emit MemberAdded(member);
    }

    function removeMember(address member) external onlyOwner {
        require(member != address(0), "Invalid member address");
        require(members[member], "Member does not exist");

        members[member] = false;
        emit MemberRemoved(member);
    }
}
