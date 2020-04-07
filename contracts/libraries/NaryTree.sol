pragma solidity >=0.4.22 <0.7.0;


library NaryTree {
    struct SortitionSumTree {
        uint K; // The maximum number of childs per node.
        // We use this to keep track of vacant positions in the tree after removing a leaf. This is for keeping the tree as balanced as possible without spending gas on moving nodes around.
        uint[] stack;
        bytes32[] nodes;
        // Two-way mapping of IDs to node indexes. Note that node index 0 is reserved for the root node, and means the ID does not have a node.
        mapping(bytes32 => uint) IDsToNodeIndexes;
        mapping(uint => bytes32) nodeIndexesToIDs;
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
    
    event consoleIfFirstChild(uint treeindex, uint treemod);
    
    function set(SortitionSumTrees storage self, bytes32 _key, bytes32 _value, bytes32 _ID) public {
        SortitionSumTree storage tree = self.sortitionSumTrees[_key];
        uint treeIndex = tree.IDsToNodeIndexes[_ID];
        if (treeIndex == 0) {
            if(_value != bytes32(0)) {
                if(tree.stack.length == 0){
                    treeIndex = tree.nodes.length;
                    tree.nodes.push(_value);
                    
                    emit consoleIfFirstChild(treeIndex, (treeIndex - 1) % tree.K );
                    
                    if(treeIndex !=1 && (treeIndex - 1) % tree.K == 0) { // Is first child
                        uint parentIndex = treeIndex / tree.K;
                        bytes32 parentID = tree.nodeIndexesToIDs[parentIndex];
                        uint newIndex = treeIndex + 1;
                        tree.nodes.push(tree.nodes[parentIndex]);
                        delete tree.nodeIndexesToIDs[parentIndex];
                        tree.IDsToNodeIndexes[parentID] = newIndex;
                        tree.nodeIndexesToIDs[newIndex] = parentID;
                        
                    }
                } else {
                    treeIndex = tree.stack[tree.stack.length - 1];
                    tree.stack.pop();
                    tree.nodes[treeIndex] = _value;
                }
                tree.IDsToNodeIndexes[_ID] = treeIndex;
                tree.nodeIndexesToIDs[treeIndex] = _ID;
                
            }
        }
        
        
    }
    

        
}

