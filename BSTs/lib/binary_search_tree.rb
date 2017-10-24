# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

require 'bst_node'

class BinarySearchTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def insert(value)
    unless @root
      @root = BSTNode.new(value)
    else
      parent = parent_for_new(@root, value)
      value > parent.value ?
      parent.right = BSTNode.new(value)
      : parent.left = BSTNode.new(value)
    end
  end

  def find(value, tree_node = @root)
    return nil if value > tree_node.value &&
                          !tree_node.right ||
                          value < tree_node.value && !tree_node.left

    if tree_node.value == value
      return tree_node
    elsif tree_node.value < value
      return find(value, tree_node.right)
    else
      return find(value, tree_node.left)
    end
  end

  def delete(value)
    current_node = find(value, @root)
    current_left = current_node.left
    current_right = current_node.right
    current_parent = parent(current_node.value, @root) if current_node != @root

    if !current_node.left && !current_node.right
      if current_node == @root
        @root = nil
      elsif current_parent.left.value == current_node.value
        current_parent.left = nil
      else
        current_parent.right = nil
      end
    elsif !current_node.right
      current_parent.left = current_node.left
    elsif !current_node.left
      current_parent.right = current_node.right
    else
      max = maximum(current_node.left)

      max_parent = parent(max.value, @root)
      max_child = max.left

      current_parent.value < current_node.value ?
      current_parent.right = max
      : current_parent.left = max

      max_parent.right = max_child
      max.right = current_right
      max.left = current_left
    end

  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node unless tree_node.right
    return maximum(tree_node.right) if tree_node.right
  end

  def depth(tree_node = @root)
    return -1 unless tree_node
    right = depth(tree_node.right)
    left = depth(tree_node.left)
    left > right ? 1 + left : 1 + right
  end

  def is_balanced?(tree_node = @root)
    return true unless tree_node
    depths_equal = (depth(tree_node.left) - depth(tree_node.right)).abs <=1
    children_balanced = is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
    depths_equal && children_balanced
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return arr unless tree_node
    left, right = tree_node.left, tree_node.right
    in_order_traversal(left, arr) + [tree_node.value] + in_order_traversal(right, arr)


  end


  private
  # optional helper methods go here:
  def parent_for_new(tree_node, value)
    return tree_node if !tree_node.left && value < tree_node.value
    return tree_node if !tree_node.right && value > tree_node.value

    if value > tree_node.value
      return parent_for_new(tree_node.right, value)
    else
      return parent_for_new(tree_node.left, value)
    end
  end

  def parent(value, tree_node)
    if tree_node.left
      return tree_node if tree_node.left.value == value
    end
    if tree_node.right
      return tree_node if tree_node.right.value == value
    end
    
    if tree_node.value > value
      return parent(value, tree_node.left)
    else
      return parent(value, tree_node.right)
    end
  end

end
