require 'set'

class Graph
  def initialize
    @adjacency_list = Hash.new { |h, k| h[k] = Set.new }
  end

  def add_vertex(id)
    @adjacency_list[id]
  end

  def delete_vertex(id)
    @adjacency_list.delete(id)
  end

  def create_edge(id1, id2)
    @adjacency_list[id1].add(id2)
    @adjacency_list[id2].add(id1)
  end

  def delete_edge(id1, id2)
    @adjacency_list[id1].delete(id2)
    @adjacency_list[id2].delete(id1)
  end
end
