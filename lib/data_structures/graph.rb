require 'set'

class Graph
  def initialize
    @adjacency_list = Hash.new { |h, k| h[k] = Set.new }
  end

  def [](id)
    @adjacency_list[id]
  end

  def add_vertex(id)
    raise RuntimeError.new("#{id} is already a Vertex") if @adjacency_list.include?(id)
    @adjacency_list[id]
  end

  def delete_vertex(id)
    raise RuntimeError.new("#{id} is not a Vertex") unless @adjacency_list.include?(id)
    @adjacency_list.delete(id)
  end

  def create_edge(id1, id2)
    raise RuntimeError.new("#{id1} is not a Vertex") unless @adjacency_list.include?(id1)
    raise RuntimeError.new("#{id2} is not a Vertex") unless @adjacency_list.include?(id2)
    @adjacency_list[id1].add(id2)
    @adjacency_list[id2].add(id1)
  end

  def delete_edge(id1, id2)
    raise RuntimeError.new("#{id1} is not a Vertex") unless @adjacency_list.include?(id1)
    raise RuntimeError.new("#{id1} is not connected to #{id2}") unless @adjacency_list[id1].include?(id2)
    @adjacency_list[id1].delete(id2)
    @adjacency_list[id2].delete(id1)
  end

  def depth_first_search(target_id, start_id=nil)
    @memo = Set.new unless start_id
    @memo ||= Set.new
    current_vertex = start_id || @adjacency_list.first.first

    current_adjacency_list = @adjacency_list[current_vertex]
    current_adjacency_list.each do |vertex|
      if @memo.include?(vertex)
        next
      else
        @memo.add(vertex)
      end

      return true if vertex == target_id
      result = depth_first_search(target_id, vertex)
      return result if result
    end

    false
  end

  def breadth_first_search(target_id, start_id=nil)
    start_id ||= @adjacency_list.first.first
    vertex_queue = [start_id]

    memo = Set.new
    while true
      current_vertex = vertex_queue.shift
      next if memo.include?(current_vertex)

      current_adjacency_list = @adjacency_list[current_vertex]
      return false if current_adjacency_list.nil?
      return true if current_adjacency_list.include?(target_id)

      vertex_queue += current_adjacency_list.to_a
      memo.add(current_vertex)
    end
  end
end
