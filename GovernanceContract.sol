// GovernanceContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GovernanceContract {
    address public admin;
    uint256 public proposalCount;

    struct Proposal {
        uint256 id;
        string description;
        uint256 forVotes;
        uint256 againstVotes;
        bool executed;
    }

    mapping(uint256 => Proposal) public proposals;

    event ProposalCreated(uint256 id, string description);
    event Voted(uint256 id, bool inSupport, address voter);
    event ProposalExecuted(uint256 id);

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not the admin");
        _;
    }

    function createProposal(string memory description) external onlyAdmin {
        uint256 id = proposalCount++;
        proposals[id] = Proposal(id, description, 0, 0, false);
        emit ProposalCreated(id, description);
    }

    function vote(uint256 id, bool inSupport) external {
        require(id < proposalCount, "Invalid proposal ID");
        Proposal storage proposal = proposals[id];
        require(!proposal.executed, "Proposal already executed");

        if (inSupport) {
            proposal.forVotes++;
        } else {
            proposal.againstVotes++;
        }

        emit Voted(id, inSupport, msg.sender);
    }

    function executeProposal(uint256 id) external onlyAdmin {
        require(id < proposalCount, "Invalid proposal ID");
        Proposal storage proposal = proposals[id];
        require(!proposal.executed, "Proposal already executed");

        if (proposal.forVotes > proposal.againstVotes) {
            // Execute the proposal
            proposal.executed = true;
            emit ProposalExecuted(id);
        }
    }
}
