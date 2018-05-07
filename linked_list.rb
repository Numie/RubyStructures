class LinkedList
  def initialize(head=nil, tail=nil)
    @head = Node.new
    @tail = Node.new
    @head.send(:next=, @tail)
    @tail.send(:prev=, @head)
  end

  def empty?
    @head.send(:next) == @tail
  end

  def first
    first = @head.send(:next)
    first == @tail ? nil : first
  end

  def last
    last = @tail.send(:prev)
    last == @head ? nil : last
  end

  def append(node)
    raise ArgumentError.new("Attempted to append #{node.class}. Argument must be a Node.") unless node.class == Node
    last = @tail.send(:prev)

    last.send(:next=, node)
    @tail.send(:prev=, node)

    node.send(:prev=, last)
    node.send(:next=, @tail)
  end

  def prepend(node)
    raise ArgumentError.new("Attempted to prepend #{node.class}. Argument must be a Node.") unless node.class == Node
    first = @head.send(:next)

    first.send(:prev=, node)
    @head.send(:next=, node)

    node.send(:prev=, @head)
    node.send(:next=, first)
  end

end

class Node
  def initialize(data=nil, next_node=nil, prev_node=nil)
    @data = data
    @next = next_node
    @prev = prev_node
  end

  private

  attr_accessor :data, :next, :prev
end
