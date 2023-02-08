// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.15;

contract OptimizedVote {
    struct Voter {
        uint8 vote;
        bool voted;
    }

    struct Proposal {
        uint8 voteCount;
        bytes32 name;
        bool ended;
    }

    mapping(address => Voter) public voters;

    Proposal[] proposals;

    function createProposal(bytes32 _name) external returns (uint256 slot) {
        assembly {
            // Get the slot where we have our proposals
            slot := sload(proposals.slot)
        }

        // Create an empty one
        proposals.push();

        // Grab the new empty proposal
        Proposal storage newProposal = proposals[slot];

        // Set the name
        newProposal.name = _name;

        // Increment slot to the next position
        unchecked { ++slot; }
    }

    function vote(uint8 _proposal) external {
        Voter storage voter = voters[msg.sender];

        require(!voter.voted, 'already voted');

        voter.vote = _proposal;
        voter.voted = true;

        unchecked {
            ++proposals[_proposal].voteCount;
        }

    }

    function getVoteCount(uint8 _proposal) external view returns (uint8) {
        return proposals[_proposal].voteCount;
    }
}
