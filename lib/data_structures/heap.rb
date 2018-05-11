class Heap
  def initialize
    @store = []
  end

  def peek
    raise ArgumentError.new('Heap is empty') if @store.empty?
    @store.first
  end

  def insert(el)
    @store << el

    el_idx = @store.length - 1
    parent_idx = parent_idx(el_idx)

    heapify_up(el_idx, parent_idx)

    el
  end

  def extract
    raise ArgumentError.new('Heap is empty') if @store.empty?
    return @store.shift if @store.length <= 2

    @store[0], @store[-1] = @store[-1], @store[0]
    head = @store.pop

    el_idx = 0
    children_indices = children_indices(el_idx)

    heapify_down(el_idx, children_indices)

    head
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
    return if children_indices.empty?
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
      heapify_down(lowest_child_idx, children_indices)
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
