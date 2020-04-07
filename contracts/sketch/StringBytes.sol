pragma solidity >=0.4.22 <0.7.0;

contract StringBytes {
    
    
    function stringToBytes32(string memory source) public pure returns (bytes32 result) {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
        return 0x0;
    }

    assembly {
        result := mload(add(source, 32))
    }
        }
        
  function intToByte32(uint data) public pure returns (bytes32 result) {
      
      bytes32 myresult = bytes32(data);
      
      return myresult;
  }
}