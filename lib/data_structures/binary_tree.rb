require 'set'

class BinaryTree
  def self.array_to_tree(array)
    binary_tree = BinaryTree.new
    return binary_tree if array.empty?

    head_node = BinaryTreeNode.new(array.first)
    binary_tree.send(:head=, head_node)
    return binary_tree if array.length == 1

    current_node = head_node
    node_arr = []
    array[1..-1].each do |el|
      node = BinaryTreeNode.new(el, current_node)
      node_arr << node
      binary_tree.send(:leaves).add(node)
      current_node.send(:children).add(node)
      binary_tree.send(:leaves).delete?(current_node)
      current_node = node_arr.shift if current_node.send(:children).length == 2
    end

    binary_tree
  end

  def initialize
    @head = nil
    @leaves = Set.new
  end

  private

  attr_accessor :head
  attr_reader :leaves
end

class BinaryTreeNode
  def initialize(val=nil, parent=nil, children=Set.new)
    @val = val
    @parent = parent
    @children = children
  end

  def to_s
    val
  end

  def inspect
    val
  end

  private

  attr_accessor :val, :parent, :children
end
