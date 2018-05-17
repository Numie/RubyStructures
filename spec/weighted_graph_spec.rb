require 'rspec'
require 'data_structures/weighted_graph'

describe WeightedGraph do
  let(:graph) { WeightedGraph.new }

  describe '#initialize' do
    it 'initializes its adjacency list to an empty Hash' do
      expect(graph.instance_variable_get(:@adjacency_list).empty?).to eq(true)
      expect(graph.instance_variable_get(:@adjacency_list)).to be_a(Hash)
    end
    it 'sets the default adjacency list value to a Hash' do
      expect(graph[1]).to be_a(Hash)
    end
  end

  describe '#create_edge' do
    it 'adds the weight of the edge to each vertex in the adjacency list' do
      graph.create_edge(1, 2, 50)
      expect(graph.instance_variable_get(:@adjacency_list)[1][2]).to eq(50)
      expect(graph.instance_variable_get(:@adjacency_list)[2][1]).to eq(50)
    end
  end
end
