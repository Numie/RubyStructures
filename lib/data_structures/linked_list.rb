class LinkedList
  include Enumerable

  def initialize
    @head = LinkedListNode.new
    @tail = LinkedListNode.new
    @head.send(:next=, @tail)
    @tail.send(:prev=, @head)
  end

  def to_a
    self.reduce([]) { |arr, n| arr << n.send(:val) }
  end

  def to_s
    return "-" if self.empty?

    vals = self.to_a { |n| n.send(:val) }
    vals.join(' <=> ')
  end

  def inspect
    return "-" if self.empty?

    vals = self.to_a { |n| n.send(:val) }
    vals.join(' <=> ')
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

  def append(key=nil, val=nil)
    node = LinkedListNode.new(key, val)
    last = @tail.send(:prev)

    last.send(:next=, node)
    @tail.send(:prev=, node)

    node.send(:prev=, last)
    node.send(:next=, @tail)

    node
  end

  def prepend(key=nil, val=nil)
    node = LinkedListNode.new(key, val)
    first = @head.send(:next)

    first.send(:prev=, node)
    @head.send(:next=, node)

    node.send(:prev=, @head)
    node.send(:next=, first)

    node
  end

  def add_after_key(ref_key, key, val)
    ref_node = self.find_by_key(ref_key)
    raise ArgumentError.new("No Node found with key=#{ref_key}") if ref_node.nil?

    node = LinkedListNode.new(key, val)
    next_node = ref_node.send(:next)

    node.send(:next=, next_node)
    node.send(:prev=, ref_node)

    ref_node.send(:next=, node)
    next_node.send(:prev=, node)

    node
  end

  def add_before_key(ref_key, key, val)
    ref_node = self.find_by_key(ref_key)
    raise ArgumentError.new("No Node found with key=#{ref_key}") if ref_node.nil?

    node = LinkedListNode.new(key, val)
    prev_node = ref_node.send(:prev)

    node.send(:next=, ref_node)
    node.send(:prev=, prev_node)

    ref_node.send(:prev=, node)
    prev_node.send(:next=, node)

    node
  end

  def find_by_key(key)
    self.each { |node| return node if node.send(:key) == key }
    nil
  end

  def find_by_val(val)
    self.each { |node| return node if node.send(:val) == val }
    nil
  end

  def include_key?(key)
    self.each { |node| return true if node.send(:key) == key }
    false
  end

  def include_val?(val)
    self.each { |node| return true if node.send(:val) == val }
    false
  end

  def remove(key)
    node = self.find_by_key(key)
    return nil if node.nil?

    prev_node = node.send(:prev)
    next_node = node.send(:next)

    prev_node.send(:next=, next_node)
    next_node.send(:prev=, prev_node)

    node
  end

  def update(key, new_val)
    node = self.find_by_key(key)
    raise ArgumentError.new("Couldn't find Node with key=#{key}") if node.nil?

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
end

class LinkedListNode
  def initialize(key=nil, val=nil, next_node=nil, prev_node=nil)
    @key = key
    @val = val
    @next = next_node
    @prev = prev_node
  end

  def to_s
    @val
  end

  def inspect
    @val
  end

  private

  attr_accessor :key, :val, :next, :prev
end
