class BinaryTree
  def self.from_array(array)
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
      binary_tree.send(:leaves) << node
      current_node.send(:children) << node
      binary_tree.send(:leaves).delete(current_node)
      current_node = node_arr.shift if current_node.send(:children).length == 2
    end

    binary_tree
  end

  def initialize
    @head = nil
    @leaves = []
  end

  def depth_first_search(target=nil, &prc)
    raise ArgumentError.new('Must pass either a target value or a block') unless (target || prc) && !(target && prc)
    prc ||= Proc.new { |node| node.send(:val) == target }

    return nil if @head.nil?
    @head.send(:depth_first_search, &prc)
  end

  private

  attr_accessor :head
  attr_reader :leaves
end

class BinaryTreeNode
  def initialize(val=nil, parent=nil, children=[])
    @val = val
    @parent = parent
    @children = children
  end

  def to_s
    @val
  end

  def inspect
    @val
  end

  private

  def depth_first_search(&prc)
    return self if prc.call(self)

    @children.each do |child|
      result = child.send(:depth_first_search, &prc)
      return result unless result.nil?
    end

    nil
  end

  attr_accessor :val, :parent, :children
end
