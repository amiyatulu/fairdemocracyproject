pragma solidity >=0.4.22 <0.7.0;


library NaryTree {
    struct SortitionSumTree {
        uint K; // The maximum number of childs per node.
        // We use this to keep track of vacant positions in the tree after removing a leaf. This is for keeping the tree as balanced as possible without spending gas on moving nodes around.
        uint[] stack;
        bytes32[] nodes;
        // Two-way mapping of IDs to node indexes. Note that node index 0 is reserved for the root node, and means the ID does not have a node.
        mapping(bytes32 => bytes32) IDsToNodeIndexes;
        mapping(bytes32 => bytes32) nodeIndexesToIDs;
    }

    /* Storage */

    struct SortitionSumTrees {
        mapping(bytes32 => SortitionSumTree) sortitionSumTrees;
    }

    /* Public */

    /**
     *  @dev Create a sortition sum tree at the specified key.
     *  @param _key The key of the new tree.
     *  @param _K The number of children each node in the tree should have.
     */
    function createTree(SortitionSumTrees storage self, bytes32 _key, uint _K) public {
        SortitionSumTree storage tree = self.sortitionSumTrees[_key];
        require(tree.K == 0, "Tree already exists.");
        require(_K > 1, "K must be greater than one.");
        tree.K = _K;
        delete tree.stack;
        delete tree.nodes;
        tree.nodes.push(bytes32(0));
    }

    // function set(sortitionSumTrees storage self, bytes32 _key, bytes32 _value, bytes32 _ID) public {
    //     SortitionSumTree storage tree = self.sortitionSumTrees[_key];
    //     uint treeIndex = tree.IDsToNodeIndexes[_ID];
    //     if (treeIndex == 0) {
    //         if(_value != 0) {}
    //     }

    // }

}
