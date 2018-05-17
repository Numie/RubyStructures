require 'rspec'
require 'data_structures/directed_graph'

describe DirectedGraph do
  let(:graph) { DirectedGraph.new }

  before(:each) do
    graph.add_vertex(1)
    graph.add_vertex(2)
    graph.create_edge(1, 2)
  end

  describe '#create_edge' do
    it 'adds the end vertex to the origin vertex\'s adjacency list' do
      expect(graph[1]).to include(2)
    end
    it 'does not add the origin vertex to the end vertex\'s adjacency list' do
      expect(graph[2]).to_not include(1)
    end
  end

  describe '#delete_edge' do
    it 'deletes the end vertex fro the origin vertex\'s adjacency list' do
      graph.delete_edge(1, 2)
      expect(graph[1]).to_not include(2)
    end
  end
end
