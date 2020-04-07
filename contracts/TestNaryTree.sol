pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;

import "./libraries/NaryTree.sol";
contract TestNaryTee {

    using NaryTree for NaryTree.SortitionSumTrees;  // See the end s
    NaryTree.SortitionSumTrees internal sortitionSumTrees; // First s is small case and end has s

    function _createTree(bytes32 _key, uint _K) public {
        sortitionSumTrees.createTree(_key, _K);
    }

    function _sortitionSumTrees(bytes32 _key) public view returns(uint K, uint[] memory stack, bytes32[] memory nodes) {
        return (
            sortitionSumTrees.sortitionSumTrees[_key].K,
            sortitionSumTrees.sortitionSumTrees[_key].stack,
            sortitionSumTrees.sortitionSumTrees[_key].nodes
        );
    }

      function _set(bytes32 _key, bytes32 _value, bytes32 _ID) public {
        sortitionSumTrees.set(_key, _value, _ID);
    }

}