require_relative 'heap'

class PriorityQueue < Heap
  def self.from_array(array)
    nodes = array.map { |arr| PriorityQueueNode.new(arr.first, arr.last) }
    heap = super(nodes)
    from_heap(heap)
  end

  def self.from_hash(hash)
    nodes = hash.map { |k, v| PriorityQueueNode.new(k, v) }
    heap = self.superclass.from_array(nodes)
    from_heap(heap)
  end

  def insert(data, priority)
    node = PriorityQueueNode.new(data, priority)
    super(node)
  end

  def merge(other_queue)
    raise ArgumentError.new("May only merge with a Priority Queue. You passed a #{other_queue.class}.") unless other_queue.is_a?(PriorityQueue)
    array = self.send(:store) + other_queue.send(:store)
    heap = self.class.superclass.from_array(array)
    self.class.send(:from_heap(heap))
  end

  private

  def self.from_heap(heap)
    queue = PriorityQueue.new
    queue.instance_variable_set(:@store, heap.send(:store))
    queue
  end
end

class PriorityQueueNode
  def initialize(data, priority)
    @data = data
    @priority = priority
  end

  def method_missing(method, other_node)
    if [:<, :<=, :>, :>=].include?(method)
      @priority.send(method, other_node.send(:priority))
    else
      super
    end
  end

  private

  attr_reader :data, :priority
end
