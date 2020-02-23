pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;

contract BytesToScore {
    
    bytes public votedata;
    
    function insertVotedata(bytes calldata  _votedata) external {
        votedata = _votedata;
    }
    
    function getVotedata(uint _index) external view returns (uint8) {
        
        return uint8(votedata[_index]);
        
    }
    
     function getIndexdata(uint _index) external view returns (bytes1) {
        
        return votedata[_index];
        
    }
}