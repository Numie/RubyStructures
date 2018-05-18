class WeightedGraph
  def initialize
    @adjacency_list = Hash.new { |h, k| h[k] = {} }
  end

  def [](id)
    @adjacency_list[id]
  end

  def add_vertex(id)
    @adjacency_list[id]
  end

  def delete_vertex(id)
    @adjacency_list.delete(id)
  end

  def create_edge(id1, id2, weight)
    @adjacency_list[id1][id2] = weight
    @adjacency_list[id2][id1] = weight
  end

  def delete_edge(id1, id2)
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

  def heighest_weight_adjacent(id)
    adjacent_vertices = self.adjacent_vertices(id)
    return nil if adjacent_vertices.empty?

    highest = nil
    highest_weight = nil
    adjacent_vertices.each do |vertex, weight|
      if highest_weight == nil || weight > highest_weight
        highest = vertex
        highest_weight = weight
      end
    end

    highest
  end

  def lowest_weight_adjacent(id)
    adjacent_vertices = self.adjacent_vertices(id)
    return nil if adjacent_vertices.empty?

    lowest = nil
    lowest_weight = nil
    adjacent_vertices.each do |vertex, weight|
      if lowest_weight == nil || weight < lowest_weight
        lowest = vertex
        lowest_weight = weight
      end
    end

    lowest
  end

end
