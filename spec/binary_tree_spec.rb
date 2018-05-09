require 'rspec'
require 'data_structures/binary_tree'

describe BinaryTree do
  let(:array) { [1, 2, 3, 4, 5, 6, 7] }
  let(:binary_tree) { BinaryTree.from_array(array) }
  let(:empty_binary_tree) { BinaryTree.new }

  describe '::from_array' do
    it 'sets the head node' do
      expect(binary_tree.send(:head).send(:val)).to eq(1)
    end
    it 'sets the leaf nodes' do
      leaves = binary_tree.send(:leaves).map { |node| node.send(:val)}
      expect(leaves).to eq([4, 5, 6, 7])
    end
  end

  describe '#depth_first_search' do
    context 'when neither a target nor a proc is passed' do
      it 'raises an error' do
        expect{ binary_tree.depth_first_search }.to raise_error
      end
    end

    context 'when both a target and a proc are passed' do
      let(:prc) { Proc.new { |node| node.send(:val) == 1 } }
      it 'raises an error' do
        expect{ binary_tree.depth_first_search(1, &prc) }.to raise_error
      end
    end

    context 'when a target is passed that does not exist in the tree' do
      it 'returns nil' do
        expect(binary_tree.depth_first_search(8)).to eq(nil)
      end
    end

    context 'when a target is passed that does exist in the tree' do
      let(:prc) { Proc.new { |node| node.send(:val) == 3 || node.send(:val) == 4 } }
      it 'returns the correct Node' do
        node = binary_tree.depth_first_search(&prc)
        expect(node.send(:val)).to eq(4)
      end
      it 'yields Nodes in the correct order' do
        node1 = binary_tree.send(:head)
        node2, node3 = node1.send(:children).first, node1.send(:children).last
        node4, node5 = node2.send(:children).first, node2.send(:children).last
        node6, node7 = node3.send(:children).first, node3.send(:children).last
        expect{ |prc| binary_tree.depth_first_search(&prc) }.to yield_successive_args(node1, node2, node4, node5, node3, node6, node7)
      end
    end
  end
end
