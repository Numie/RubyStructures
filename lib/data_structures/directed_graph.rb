require_relative 'graph'

class DirectedGraph < Graph
  def create_edge(origin_id, end_id)
    @adjacency_list[origin_id].add(end_id)
  end

  def delete_edge(origin_id, end_id)
    @adjacency_list[origin_id].delete(end_id)
  end
end
