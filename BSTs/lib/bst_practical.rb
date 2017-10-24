
def kth_largest(tree_node, k)
	myTree = BinarySearchTree.new()
  arr = myTree.in_order_traversal(tree_node, [])
  myTree.find(arr[arr.length-k], tree_node)
end
