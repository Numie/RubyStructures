require_relative 'heap'

class MaxHeap < Heap
  def find(el)
    return nil if @store.empty? || el > @store.first
    @store.each { |store_el| return store_el if store_el == el }
    nil
  end

  private

  def heapify_up(el_idx, parent_idx)
    until el_idx == 0 || @store[el_idx] <= @store[parent_idx]
      @store[el_idx], @store[parent_idx] = @store[parent_idx], @store[el_idx]
      el_idx = parent_idx
      parent_idx = parent_idx(el_idx)
    end
  end

  def heapify_down(el_idx, children_indices)
    if children_indices.length == 1
      child_idx = children_indices.first
      if @store[el_idx] < @store[child_idx]
        @store[el_idx], @store[child_idx] = @store[child_idx], @store[el_idx]
      end
      return
    elsif @store[el_idx] < @store[children_indices.first] || @store[el_idx] < @store[children_indices.last]
      child1, child2 = @store[children_indices.first], @store[children_indices.last]
      highest_child_idx = child1 >= child2 ? children_indices.first : children_indices.last
      @store[el_idx], @store[highest_child_idx] = @store[highest_child_idx], @store[el_idx]

      children_indices = children_indices(highest_child_idx)
      heapify_down(highest_child_idx, children_indices) unless children_indices.empty?
    end
  end
end
