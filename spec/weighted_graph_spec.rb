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

  describe '#highest_weight_adjacent' do
    context 'when the vertex does not exist in the Graph' do
      it 'raises an error' do
        graph.add_vertex(1)
        expect{ graph.highest_weight_adjacent(2) }.to raise_error
      end
    end
    context 'when there are no adjacent vertices' do
      it 'returns nil' do
        graph.add_vertex(1)
        graph.add_vertex(2)
        expect(graph.highest_weight_adjacent(1)).to eq(nil)
      end
    end

    context 'when there are adjacent vertices' do
      it 'returns the vertex with the highest weight' do
        graph.add_vertex(1)
        graph.add_vertex(2)
        graph.add_vertex(3)
        graph.add_vertex(4)
        graph.create_edge(1, 2, 50)
        graph.create_edge(1, 3, 65)
        graph.create_edge(1, 4, 60)
        expect(graph.highest_weight_adjacent(1)).to eq(3)
      end
    end
  end

  describe '#lowest_weight_adjacent' do
    context 'when the vertex does not exist in the Graph' do
      it 'raises an error' do
        graph.add_vertex(1)
        expect{ graph.lowest_weight_adjacent(2) }.to raise_error
      end
    end
    context 'when there are no adjacent vertices' do
      it 'returns nil' do
        graph.add_vertex(1)
        graph.add_vertex(2)
        expect(graph.lowest_weight_adjacent(1)).to eq(nil)
      end
    end

    context 'when there are adjacent vertices' do
      it 'returns the vertex with the lowest weight' do
        graph.add_vertex(1)
        graph.add_vertex(2)
        graph.add_vertex(3)
        graph.add_vertex(4)
        graph.create_edge(1, 2, 50)
        graph.create_edge(1, 3, 65)
        graph.create_edge(1, 4, 60)
        expect(graph.lowest_weight_adjacent(1)).to eq(2)
      end
    end
  end
end
