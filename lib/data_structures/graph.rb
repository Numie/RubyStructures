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

  def adjacent?(id1, id2)
    raise RuntimeError.new("#{id1} is not a Vertex") unless @adjacency_list.include?(id1)
    raise RuntimeError.new("#{id2} is not a Vertex") unless @adjacency_list.include?(id2)
    @adjacency_list[id1].include?(id2)
  end

  def adjacent_vertices(id)
    raise RuntimeError.new("#{id} is not a Vertex") unless @adjacency_list.include?(id)
    @adjacency_list[id]
  end

  def depth_first_search(target_id=nil, start_id=nil, &prc)
    raise ArgumentError.new('Must pass either a target value or a block') unless (target_id || prc) && !(target_id && prc)
    prc ||= Proc.new { |vertex| vertex == target_id }

    return false if @adjacency_list.empty?
    current_vertex = start_id || @adjacency_list.first.first
    @memo = Set.new unless start_id
    @memo ||= Set.new

    unless @memo.include?(current_vertex)
      return true if prc.call(current_vertex)
      @memo.add(current_vertex)
    end

    current_adjacency_list = @adjacency_list[current_vertex]
    current_adjacency_list.each do |vertex|
      if @memo.include?(vertex)
        next
      else
        @memo.add(vertex)
      end

      return true if prc.call(vertex)
      result = depth_first_search(nil, vertex, &prc)
      return result if result
    end

    false
  end

  def breadth_first_search(target_id=nil, start_id=nil, &prc)
    raise ArgumentError.new('Must pass either a target value or a block') unless (target_id || prc) && !(target_id && prc)
    prc ||= Proc.new { |vertex| vertex == target_id }

    return false if @adjacency_list.empty?
    start_id ||= @adjacency_list.first.first
    vertex_queue = [start_id]

    memo = Set.new
    until vertex_queue.empty?
      current_vertex = vertex_queue.shift
      return true if prc.call(current_vertex)

      current_adjacency_list = @adjacency_list[current_vertex]

      vertex_queue += current_adjacency_list.to_a.reject { |vertex| memo.include?(vertex) }
      memo.add(current_vertex)
    end

    false
  end
end
