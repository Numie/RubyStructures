class LinkedList
  include Enumerable

  def initialize
    @head = LinkedListNode.new
    @tail = LinkedListNode.new
    @head.send(:next=, @tail)
    @tail.send(:prev=, @head)
  end

  def to_a
    self.reduce([]) {|arr, n| arr << n.send(:val)}
  end

  def to_s
    return "-" if self.empty?

    vals = self.to_a { |n| n.send(:val) }
    vals.join(' -> ')
  end

  def inspect
    return "-" if self.empty?

    vals = self.to_a { |n| n.send(:val) }
    vals.join(' -> ')
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

  def append(val=nil)
    node = LinkedListNode.new(val)
    last = @tail.send(:prev)

    last.send(:next=, node)
    @tail.send(:prev=, node)

    node.send(:prev=, last)
    node.send(:next=, @tail)

    node
  end

  def prepend(val=nil)
    node = LinkedListNode.new(val)
    first = @head.send(:next)

    first.send(:prev=, node)
    @head.send(:next=, node)

    node.send(:prev=, @head)
    node.send(:next=, first)

    node
  end

  def find(val)
    self.each { |node| return node if node.send(:val) == val }
    nil
  end

  def include?(val)
    self.each { |node| return true if node.send(:val) == val }
    false
  end

  def remove(val)
    node = self.find(val)
    return nil if node.nil?

    prev_node = node.send(:prev)
    next_node = node.send(:next)

    prev_node.send(:next=, next_node)
    next_node.send(:prev=, prev_node)

    node
  end

  def update(old_val, new_val)
    node = self.find(old_val)
    raise ArgumentError.new("Couldn't find Node with value=#{old_val}") if node.nil?

    node.send(:val=, new_val)
    node
  end

  def each(&prc)
    current_node = @head.send(:next)
    return self if current_node.nil?

    while current_node != @tail
      prc.call(current_node)
      current_node = current_node.send(:next)
    end

    self
  end

  def map(&prc)
    new_linked_list = LinkedList.new
    current_node = @head.send(:next)
    return new_linked_list if current_node.nil?

    while current_node != @tail
      val = prc.call(current_node)
      new_linked_list.append(val)
      current_node = current_node.send(:next)
    end

    new_linked_list
  end
end

class LinkedListNode
  def initialize(val=nil, next_node=nil, prev_node=nil)
    @val = val
    @next = next_node
    @prev = prev_node
  end

  def to_s
    val
  end

  def inspect
    val
  end

  private

  attr_accessor :val, :next, :prev
end
