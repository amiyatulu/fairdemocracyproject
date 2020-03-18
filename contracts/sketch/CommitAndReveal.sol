pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;

// https://karl.tech/learning-solidity-part-2-voting/

// Get the Keccak-256 hash
// https://emn178.github.io/online-tools/keccak_256.html

contract CommitRevealElection {
    
    string public choice1;
    string public choice2;
    
    
    uint public votesForChoice1;
    uint public votesForChoice2;
    uint public commitPhaseEndTime;
    uint public numberOfVotesCast = 0;
    
    bytes32[] public voteCommitsHexCode;
    mapping(bytes32 => string) public voteStatuses;
    
    event logString(string);
    event newVoteCommit(string, bytes32);
    event voteWinner(string, string);
    
    
    constructor(
        uint _commitPhaseLengthInSeconds,
        string memory _choice1,
        string memory _choice2
        ) public { 
            require(_commitPhaseLengthInSeconds > 20, "Commit phase length can't be less than 20 secs");
            commitPhaseEndTime = now + _commitPhaseLengthInSeconds * 1 seconds;
            choice1 = _choice1;
            choice2 = _choice2;
    }
    
    
    function commitVote(bytes32 _voteCommitHexCode) external {
        require(now < commitPhaseEndTime, "Commit phase has ended");
        
        bytes memory bytesVoteStatus = bytes(voteStatuses[_voteCommitHexCode]);
        require(bytesVoteStatus.length == 0, "Commit has been used before");
        
        voteCommitsHexCode.push(_voteCommitHexCode);
        voteStatuses[_voteCommitHexCode] = "Committed";
        numberOfVotesCast++;
        emit newVoteCommit("Vote commited with the hash", _voteCommitHexCode);
    }
        
   
//   function getLength(bytes32 _voteCommitHexCode) external view returns (uint) {
//         bytes memory bytesVoteCommit = bytes(voteStatuses[_voteCommitHexCode]);
//         return bytesVoteCommit.length;
       
//   }


    // function revealVote(string calldata _vote, bytes32 _voteCommitHexCode) external {
        
    //     require(now > commitPhaseEndTime, "Commit phase end time has not ended yet. Please wait");
        
    //     bytes memory bytesVoteStatus = bytes(voteStatuses[_voteCommitHexCode]);
        
    //     require(bytesVoteStatus.length != 0, "This vote commit hex code is not present");
        
        
        
    // }
    
      function getbytesVoteCommit(bytes32 _voteCommitHexCode) external view returns (bytes memory) {
        bytes memory bytesVoteCommit = bytes(voteStatuses[_voteCommitHexCode]);
        return bytesVoteCommit;
       
  }
    
    
    
}
    
