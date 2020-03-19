pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";
import "./libraries/SafeMath8.sol";
import "./libraries/SafeMath32.sol";


// Commit and Reveal Score voting
// Voting session per subdeparment code
        // Add the department code to constructor?? Really?? Is this currect way??
// Whitelisting voters
// Whitelisting nominee
// Time the voting starts // Every 6 months
// Time the voting ends // Voting process takes one month, 7 days revealing time included


contract ScoreBallot is Ownable {

    using SafeMath for uint;
    using SafeMath32 for uint32;
    using SafeMath8 for uint8;

    uint public commitPhaseLengthInSeconds;

    struct DepartmentRepresentatives {
        uint32 totalScore; // Total votes got in score voting
        bytes32 name;
        address representativesAddress; // Address of the nominees in the election
    }

    struct Poll {
        uint32 _commitPhaseLengthInSeconds;
        bytes32 departmentCode;
        uint votingCycle; // 1,2,3 etc every time voting takes place
    }

    struct voter {
        address voterAddress; // Address of the voter
        bool canVote; // If true, the voter can vote
        bool voted; // if true, the person already voted
        bytes32 departmentCode; // Code of the department
    }

    function setCommitPhaseLengthInSeconds(uint _commitPhaseLengthInSeconds) external onlyOwner {
        commitPhaseLengthInSeconds = _commitPhaseLengthInSeconds;
    }

}