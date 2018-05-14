class Heap
  def self.from_array(array)
    heap = Heap.new
    heap.instance_variable_set(:@store, array)

    heap.send(:store).length.downto(0).each do |idx|
      children_indices = heap.send(:children_indices, idx)
      heap.send(:heapify_down, idx, children_indices) unless children_indices.empty?
    end

    heap
  end

  def initialize
    @store = []
  end

  def to_a
    arr = []
    copy = self.dup
    copy.instance_variable_set(:@store, @store.dup)
    until copy.empty?
      arr << copy.extract
    end
    arr
  end

  def to_s
    "Heap: head=#{self.peek || 'nil'}, length=#{self.length}"
  end

  def inspect
    "Heap: head=#{self.peek || 'nil'}, length=#{self.length}"
  end

  def empty?
    @store.empty?
  end

  def length
    @store.length
  end

  def peek
    return nil if @store.empty?
    @store.first
  end

  def insert(el)
    @store << el

    el_idx = @store.length - 1
    parent_idx = parent_idx(el_idx)

    heapify_up(el_idx, parent_idx)

    el
  end

  def insert_mutliple(arr)
    raise ArgumentError.new("Can only insert multiple elements via an Array. You passed a #{arr.class}.") unless arr.is_a?(Array)
    array = self.send(:store) + arr
    self.class.from_array(array)
  end

  def extract
    return nil if @store.empty?
    return @store.shift if @store.length <= 2

    @store[0], @store[-1] = @store[-1], @store[0]
    head = @store.pop

    el_idx = 0
    children_indices = children_indices(el_idx)

    heapify_down(el_idx, children_indices) unless children_indices.empty?

    head
  end

  def find(el)
    return nil if @store.empty? || el < @store.first
    @store.each { |store_el| return store_el if store_el == el }
    nil
  end

  def include?(el)
    @store.include?(el)
  end

  def merge(other_heap)
    raise ArgumentError.new("May only merge with a Heap. You passed a #{other_heap.class}.") unless other_heap.is_a?(Heap)
    array = self.send(:store) + other_heap.send(:store)
    self.class.from_array(array)
  end

  private

  def heapify_up(el_idx, parent_idx)
    until el_idx == 0 || @store[el_idx] >= @store[parent_idx]
      @store[el_idx], @store[parent_idx] = @store[parent_idx], @store[el_idx]
      el_idx = parent_idx
      parent_idx = parent_idx(el_idx)
    end
  end

  def heapify_down(el_idx, children_indices)
    if children_indices.length == 1
      child_idx = children_indices.first
      if @store[el_idx] > @store[child_idx]
        @store[el_idx], @store[child_idx] = @store[child_idx], @store[el_idx]
      end
      return
    elsif @store[el_idx] > @store[children_indices.first] || @store[el_idx] > @store[children_indices.last]
      child1, child2 = @store[children_indices.first], @store[children_indices.last]
      lowest_child_idx = child1 <= child2 ? children_indices.first : children_indices.last
      @store[el_idx], @store[lowest_child_idx] = @store[lowest_child_idx], @store[el_idx]

      children_indices = children_indices(lowest_child_idx)
      heapify_down(lowest_child_idx, children_indices) unless children_indices.empty?
    end
  end

  def parent_idx(idx)
    (idx - 1) / 2
  end

  def children_indices(idx)
    idx1 = idx * 2 + 1
    idx2 = idx * 2 + 2
    [idx1, idx2].select { |idx| @store[idx] }
  end

  attr_reader :store
end
