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
      current_node.send(:left_child).nil? ? current_node.send(:left_child=, node) : current_node.send(:right_child=, node)
      binary_tree.send(:leaves).delete(current_node)
      current_node = node_arr.shift if current_node.send(:right_child)
    end

    binary_tree
  end

  def initialize
    @head = nil
    @leaves = []
  end

  def depth_first_search(target=nil, start_node=nil, &prc)
    raise ArgumentError.new('Must pass either a target value or a block') unless (target || prc) && !(target && prc)
    prc ||= Proc.new { |node| node.send(:val) == target }

    return nil if @head.nil?
    start_node ||= @head

    return start_node if prc.call(start_node)

    [start_node.send(:left_child), start_node.send(:right_child)].each do |child|
      next if child.nil?
      result = depth_first_search(nil, child, &prc)
      return result unless result.nil?
    end

    nil
  end

  def breadth_first_search(target=nil, &prc)
    raise ArgumentError.new('Must pass either a target value or a block') unless (target || prc) && !(target && prc)
    prc ||= Proc.new { |node| node.send(:val) == target }

    nodes = [@head]
    until nodes.empty?
      node = nodes.shift
      next if node.nil?
      return node if prc.call(node)
      nodes.concat([node.send(:left_child), node.send(:right_child)])
    end

    nil
  end

  private

  attr_accessor :head
  attr_reader :leaves
end

class BinaryTreeNode
  def initialize(val=nil, parent=nil, left_child=nil, right_child=nil)
    @val = val
    @parent = parent
    @left_child = left_child
    @right_child = right_child
  end

  def to_s
    @val
  end

  def inspect
    @val
  end

  private

  attr_accessor :val, :parent, :left_child, :right_child
end
