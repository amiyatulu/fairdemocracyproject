pragma solidity >=0.4.21 <0.6.0;

contract Ballot {
    struct Voter {
        bool canVote; // if true, the voter can vote
        bool voted; // if true, the person already voted
        uint vote; // index of the voted proposal
    }

    struct Proposal {
        bytes32 name; // short name (up to 32 bytes), *** Will change to ipfs hash containing profile details ***
        uint voteCount; // number or accumulate votes
    }

    address public voterReviewer; // give the right to vote to each address individually, *** it will be an array in future ***

    // This declares a state variable that
    // stores a `Voter` struct for each possible address.
    mapping(address => Voter) public voters;

    // A dynamically-sized array of `Proposal` structs.
    Proposal[] public proposals;

    /// Create a new ballot to choose one of `proposalNames`.

    // *** Now we are sending array of proposal to constructor, in future proposal can be added without constructor ***
    constructor(bytes32[] memory proposalNames) public {
        voterReviewer = msg.sender;

        // For each of the provided proposal names,
        // create a new proposal object and add it
        // to the end of the array.

        for (uint i = 0; i < proposalNames.length; i++) {
            // `Proposal({...})` creates a temporary
            // Proposal object and `proposals.push(...)`
            // appends it to the end of `proposals`.

            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));

        }
    }

       // Give `voter` the right to vote on this ballot.
    // May only be called by `chairperson`.
    function giveRightToVote(address voter) public {
        // If the first argument of `require` evaluates
        // to `false`, execution terminates and all
        // changes to the state and to Ether balances
        // are reverted.
        // This used to consume all gas in old EVM versions, but
        // not anymore.
        // It is often a good idea to use `require` to check if
        // functions are called correctly.
        // As a second argument, you can also provide an
        // explanation about what went wrong.
        require(
            msg.sender == voterReviewer,
            "Only voterReviewer can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        voters[voter].canVote = true;
    }

    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.canVote, "Has no right to vote");
        require(!sender.voted, "Already voted");
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += 1;

    }

    // *** Here it returns a single winner, have to refactor for multiple winnners ***
    function winningProposal() public view returns (uint winningProposal_) {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    function winnerName() public view
            returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }


    }



