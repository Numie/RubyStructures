require 'rspec'
require 'data_structures/graph'

describe Graph do
  let(:graph) { Graph.new }

  describe '#add_vertex' do
    context 'when a Graph already contains a vertex' do
      it 'raises an error' do
        graph.add_vertex(1)
        expect{ graph.add_vertex(1) }.to raise_error
      end
    end

    context 'when a Graph does not contain a vertex' do
      it 'adds the vertex to the Graph' do
        graph.add_vertex(1)
        expect(graph.instance_variable_get(:@adjacency_list)).to include(1)
      end
      it 'returns the vertex\'s adjacency list'  do
        expect(graph.add_vertex(1)).to be_a(Set)
      end
    end
  end

  describe '#delete_vertex' do
    context 'when a Graph does not contain a vertex' do
      it 'raises an error' do
        expect{ graph.delete_vertex(1) }.to raise_error
      end
    end

    context 'when a Graph does contain a vertex' do
      before(:each) { graph.add_vertex(1) }
      it 'deletes the vertex' do
        graph.delete_vertex(1)
        expect(graph.instance_variable_get(:@adjacency_list)).to_not include(1)
      end
      it 'returns the vertex\'s adjacency list'  do
        expect(graph.delete_vertex(1)).to be_a(Set)
      end
    end
  end

  describe '#create_edge' do
    context 'when a Graph does not include either vertex' do
      it 'raises an error' do
        expect{ graph.create_edge(1, 2) }.to raise_error
        graph.add_vertex(1)
        expect{ graph.create_edge(1, 2) }.to raise_error
      end
    end

    context 'when a Graph does include both vertices' do
      it 'adds each vertex to the other\'s adjacency list' do
        graph.add_vertex(1)
        graph.add_vertex(2)
        graph.create_edge(1, 2)
        expect(graph[1]).to include(2)
        expect(graph[2]).to include(1)
      end
    end
  end

  describe '#delete_edge' do
    context 'when a Graph does not include a vertex' do
      it 'raises an error' do
        expect{ graph.delete_edge(1, 2) }.to raise_error
      end
    end

    context 'when a vertex\'s adjacency_list does not contain a second vertex' do
      it 'raises an error' do
        graph.add_vertex(1)
        expect{ graph.delete_edge(1, 2) }.to raise_error
      end
    end

    context 'when an edge can be deleted' do
      before do
        graph.add_vertex(1)
        graph.add_vertex(2)
        graph.create_edge(1, 2)
      end
      it 'deletes each vertex from the other\'s adjacency list' do
        graph.delete_edge(1, 2)
        expect(graph[1]).to_not include(2)
        expect(graph[2]).to_not include(1)
      end
    end
  end

  describe '#adjacent?' do
    context 'when a Graph does not include either vertex' do
      it 'raises an error' do
        expect{ graph.create_edge(1, 2) }.to raise_error
        graph.add_vertex(1)
        expect{ graph.create_edge(1, 2) }.to raise_error
      end
    end

    context 'when a Graph includes both vertices' do
      before(:each) do
        graph.add_vertex(1)
        graph.add_vertex(2)
      end
      it 'returns false when there is no adjacency' do
        expect(graph.adjacent?(1, 2)).to eq(false)
      end
      it 'returns true when there is a adjacency' do
        graph.create_edge(1, 2)
        expect(graph.adjacent?(1, 2)).to eq(true)
      end
    end
  end

  describe '#adjacent_vertices' do
    before do
      graph.add_vertex(1)
      graph.add_vertex(2)
      graph.add_vertex(3)
      graph.add_vertex(4)
      graph.create_edge(1, 2)
      graph.create_edge(1, 3)
    end
    it 'returns all of a vertex\'s adjacent vertices' do
      set = graph.adjacent_vertices(1)
      expect(set).to include(2)
      expect(set).to include(3)
      expect(set).to_not include(4)
    end
  end

  describe '#depth_first_search' do
    let(:prc) { Proc.new { |vertex| vertex == 4 } }
    before(:each) do
      graph.add_vertex(1)
      graph.add_vertex(2)
      graph.add_vertex(3)
      graph.add_vertex(4)
      graph.create_edge(1, 2)
      graph.create_edge(1, 3)
      graph.create_edge(2, 4)
    end
    context 'when neither a target_id nor a proc is passed' do
      it 'raises an error' do
        expect{ graph.depth_first_search }.to raise_error
      end
    end

    context 'when both a target and a proc are passed' do
      let(:prc) { Proc.new { |vertex| vertex == 1 } }
      it 'raises an error' do
        expect{ graph.depth_first_search(1, &prc) }.to raise_error
      end
    end

    context 'when a Graph contains a target id' do
      it 'returns true' do
        expect(graph.depth_first_search(4)).to eq(true)
      end
      it 'traverses the Graph in a depth first manner' do
        graph.depth_first_search(4)
        expect(graph.instance_variable_get(:@memo)).to eq(Set.new([1, 2, 4]))
      end
      it 'traverses the Graph in a depth first manner, part deux' do
        expect{ |prc| graph.depth_first_search(&prc) }.to yield_successive_args(1, 2, 4, 3)
      end
      it 'calls itself recursively' do
        expect(graph).to receive(:depth_first_search).exactly(:twice).and_call_original
        graph.depth_first_search(4)
      end
      it 'resets the @memo instance variable' do
        graph.depth_first_search(4)
        graph.depth_first_search(1)
        expect(graph.instance_variable_get(:@memo)).to eq(Set.new)
      end
    end

    context 'when a Graph does not contain a target id' do
      it 'returns false' do
        expect(graph.depth_first_search(5)).to eq(false)
      end
      it 'traverses the Graph in a depth first manner' do
        graph.depth_first_search(5)
        expect(graph.instance_variable_get(:@memo)).to eq(Set.new([1, 2, 4, 3]))
      end
    end

    context 'when a Graph is empty' do
      let(:empty_graph) { Graph.new }
      it 'returns false' do
        expect(empty_graph.depth_first_search(1)).to eq(false)
      end
    end
  end

  describe '#breadth_first_search' do
    let(:prc) { Proc.new { |vertex| vertex == 4 } }
    before(:each) do
      graph.add_vertex(1)
      graph.add_vertex(2)
      graph.add_vertex(3)
      graph.add_vertex(4)
      graph.create_edge(1, 2)
      graph.create_edge(1, 3)
      graph.create_edge(2, 4)
    end
    context 'when neither a target_id nor a proc is passed' do
      it 'raises an error' do
        expect{ graph.breadth_first_search }.to raise_error
      end
    end

    context 'when both a target and a proc are passed' do
      let(:prc) { Proc.new { |vertex| vertex == 1 } }
      it 'raises an error' do
        expect{ graph.breadth_first_search(1, &prc) }.to raise_error
      end
    end

    context 'when a Graph contains a target id' do
      it 'returns true' do
        expect(graph.breadth_first_search(4)).to eq(true)
      end
      it 'traverses the Graph in a breadth first manner' do
        expect{ |prc| graph.breadth_first_search(&prc) }.to yield_successive_args(1, 2, 3, 4)
      end
    end

    context 'when a Graph does not contain a target id' do
      it 'returns false' do
        expect(graph.breadth_first_search(5)).to eq(false)
      end
    end

    context 'when a Graph is empty' do
      let(:empty_graph) { Graph.new }
      it 'returns false' do
        expect(empty_graph.breadth_first_search(1)).to eq(false)
      end
    end
  end
end
