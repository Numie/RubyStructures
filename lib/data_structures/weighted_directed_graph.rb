require_relative 'weighted_graph'

class WeightedDirectedGraph < WeightedGraph
  def create_edge(origin_id, end_id, weight)
    @adjacency_list[origin_id][end_id] = weight
  end

  def delete_edge(origin_id, end_id)
    @adjacency_list[origin_id].delete(end_id)
  end
end
