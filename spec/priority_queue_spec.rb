require 'rspec'
require 'data_structures/priority_queue'

describe PriorityQueue do
  let(:queue) { PriorityQueue.new }
  let(:empty_queue) { PriorityQueue.new }
  let(:node1) { PriorityQueueNode.new('apple', 1) }
  let(:node2) { PriorityQueueNode.new('orange', 2) }
  let(:node3) { PriorityQueueNode.new('banana', 3) }
  let(:node4) { PriorityQueueNode.new('pear', 4) }
  let(:node5) { PriorityQueueNode.new('kiwi', 5) }
  let(:node6) { PriorityQueueNode.new('mango', 6) }
  let(:node7) { PriorityQueueNode.new('grapefruit', 7) }
  before(:each) { queue.instance_variable_set(:@store, [node1, node2, node3, node4, node5, node6, node7]) }

  def valid_queue?(queue)
    queue.send(:store).each_index do |idx|
      parent_idx = queue.send(:parent_idx, idx)
      next if parent_idx < 0
      return false if queue.send(:store)[parent_idx] > queue.send(:store)[idx]
    end
    true
  end

  describe '::from_array' do
    let(:array) { [['apple', 1], ['orange', 2], ['banana', 3], ['pear', 4], ['kiwi', 5], ['mango', 6], ['grapefruit', 7]].shuffle }
    it 'converts an array into a PriorityQueue' do
      expect(PriorityQueue.from_array(array)).to be_a(PriorityQueue)
    end
    it 'correctly heapifies the array' do
      expect(valid_queue?(PriorityQueue.from_array(array))).to eq(true)
    end
  end

  describe '::from_hash' do
    let(:hash) { {'apple': 1, 'orange': 2, 'banana': 3, 'pear': 4, 'kiwi': 5, 'mango': 6, 'grapefruit': 7} }
    it 'converts a hash into a PriorityQueue' do
      expect(PriorityQueue.from_hash(hash)).to be_a(PriorityQueue)
    end
    it 'correctly heapifies the hash' do
      expect(valid_queue?(PriorityQueue.from_hash(hash))).to eq(true)
    end
  end

  describe '#to_a' do
    let(:array) { [['apple', 1], ['orange', 2], ['banana', 3], ['pear', 4], ['kiwi', 5], ['mango', 6], ['grapefruit', 7]].shuffle }
    let(:queue2) { PriorityQueue.from_array(array) }
    it 'converts a Queue to an array' do
      expect(queue2.to_a).to be_a(Array)
    end
    it 'produces an array in the correct order' do
      expect(queue2.to_a.first.send(:data)).to eq('apple')
      expect(queue2.to_a.last.send(:data)).to eq('grapefruit')
    end
    it 'preserves the original Queue' do
      queue2.to_a
      expect(queue2.send(:store).length).to eq(7)
    end
  end

  describe '#empty?' do
    context 'when a PriorityQueue is empty' do
      it 'returns true' do
        expect(empty_queue.empty?).to eq(true)
      end
    end

    context 'when a PriorityQueue is not empty' do
      it 'returns false' do
        expect(queue.empty?).to eq(false)
      end
    end
  end

  describe '#length' do
    it 'returns the length of a PriorityQueue' do
      expect(queue.length).to eq(7)
    end
  end

  describe '#peek' do
    context 'when a PriorityQueue is empty' do
      it 'returns nil' do
        expect(empty_queue.peek).to eq(nil)
      end
    end

    context 'when a PriorityQueue is not empty' do
      it 'returns the head value of the PriorityQueue' do
        expect(queue.peek).to eq(node1)
      end
    end
  end

  describe '#insert' do
    it 'increases the size of the PriorityQueue' do
      queue.insert('dragonfruit', 1)
      expect(queue.send(:store).length).to eq(8)
    end
    it 'adds the given element to the PriorityQueue' do
      queue.insert('dragonfruit', 1)
      expect(queue.send(:store).count { |n| n.send(:priority) == 1 }).to eq(2)
    end
    it 'heapifies up to keep the PriorityQueue valid' do
      queue.insert('dragonfruit', 1)
      expect(valid_queue?(queue)).to eq(true)
    end
    it 'returns the given element' do
      expect(queue.insert('dragonfruit', 1)).to be_a(PriorityQueueNode)
    end
  end

  describe '#extract' do
    context 'when a PriorityQueue is empty' do
      it 'returns nil' do
        expect(empty_queue.extract).to eq(nil)
      end
    end
    context 'when a PriorityQueue is not empty' do
      it 'decreases the size of the PriorityQueue' do
        queue.extract
        expect(queue.send(:store).length).to eq(6)
      end
      it 'removes the head element of the PriorityQueue' do
        queue.extract
        expect(queue.send(:store).include?(node1)).to eq(false)
      end
      it 'correctly sets a new head element' do
        queue.extract
        expect(queue.peek).to eq(node2)
      end
      it 'heapifies down to keep the PriorityQueue valid' do
        queue.extract
        expect(queue.send(:store)).to eq([node2, node4, node3, node7, node5, node6])
      end
      it 'returns the extracted element' do
        expect(queue.extract).to eq(node1)
      end
    end
  end

  describe '#find' do
    context 'when a PriorityQueue is empty' do
      it 'returns nil' do
        expect(empty_queue.find('dragonfruit')).to eq(nil)
      end
    end

    context 'when a PriorityQueue does not include an element' do
      it 'returns nil' do
        expect(queue.find('dragonfruit')).to eq(nil)
      end
    end

    context 'when a PriorityQueue does include an element' do
      it 'returns the element' do
        expect(queue.find('grapefruit')).to eq(node7)
      end
    end
  end

  describe '#include?' do
    context 'when a PriorityQueue does not include an element' do
      it 'returns false' do
        expect(queue.include?('dragonfruit')).to eq(false)
      end
    end

    context 'when a PriorityQueue does include an element' do
      it 'returns true' do
        expect(queue.include?('grapefruit')).to eq(true)
      end
    end
  end

  describe '#merge' do
    let(:queue2) { PriorityQueue.new }
    before(:each) { queue2.instance_variable_set(:@store, [node1, node2, node3, node4, node5, node6, node7].shuffle) }
    let(:merged_queue) { queue.merge(queue2) }
    context 'when a non-PriorityQueue object is passed' do
      it 'raises an error' do
        expect{ queue.merge(Heap.new) }.to raise_error
      end
    end
    context 'when a PriorityQueue is passed' do
      it 'returns a new PriorityQueue' do
        expect(merged_queue).to be_a(PriorityQueue)
        expect(merged_queue).to_not be(queue)
        expect(merged_queue).to_not be(queue2)
      end
      it 'returns a valid queue' do
        expect(valid_queue?(merged_queue)).to eq(true)
      end
      it 'combines both queues' do
        expect(merged_queue.send(:store).length).to eq(14)
      end
    end
  end
end
