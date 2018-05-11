require 'rspec'
require 'data_structures/heap'

describe Heap do
  let(:heap) { Heap.new }
  let(:empty_heap) { Heap.new }
  before(:each) { heap.instance_variable_set(:@store, [1, 2, 3, 4, 5, 6, 7]) }

  def valid_heap?(heap)
    heap.send(:store).each_index do |idx|
      parent_idx = heap.send(:parent_idx, idx)
      next if parent_idx < 0
      return false if heap.send(:store)[parent_idx] > heap.send(:store)[idx]
    end
    true
  end

  describe '::from_array' do
    let(:array) { (1..7).to_a.shuffle }
    it 'converts an array into a Heap' do
      expect(Heap.from_array(array)).to be_a(Heap)
    end
    it 'correctly heapifies the array' do
      expect(valid_heap?(Heap.from_array(array))).to eq(true)
    end
  end

  describe '#peek' do
    context 'when a Heap is empty' do
      it 'returns nil' do
        expect(empty_heap.peek).to eq(nil)
      end
    end

    context 'when a Heap is not empty' do
      it 'returns the head value of the Heap' do
        expect(heap.peek).to eq(1)
      end
    end
  end

  describe '#insert' do
    it 'increases the size of the Heap' do
      heap.insert(1)
      expect(heap.send(:store).length).to eq(8)
    end
    it 'adds the given element to the Heap' do
      heap.insert(1)
      expect(heap.send(:store).count(1)).to eq(2)
    end
    it 'heapifies up to keep the Heap valid' do
      heap.insert(1)
      expect(heap.send(:store)).to eq([1, 1, 3, 2, 5, 6, 7, 4])
    end
    it 'returns the given element' do
      expect(heap.insert(1)).to eq(1)
    end
  end

  describe '#insert_multiple' do
    let(:array) { (1..7).to_a.shuffle }
    it 'returns a new Heap' do
      expect(heap.insert_mutliple(array)).to be_a(Heap)
      expect(heap.insert_mutliple(array)).to_not be(heap)
    end
    it 'returns a valid heap' do
      expect(valid_heap?(heap.insert_mutliple(array))).to eq(true)
    end
    it 'combines the heap and array' do
      expect(heap.insert_mutliple(array).send(:store).length).to eq(14)
    end
  end

  describe '#extract' do
    context 'when a Heap is empty' do
      it 'returns nil' do
        expect(empty_heap.extract).to eq(nil)
      end
    end
    context 'when a Heap is not empty' do
      it 'decreases the size of the Heap' do
        heap.extract
        expect(heap.send(:store).length).to eq(6)
      end
      it 'removes the head element of the Heap' do
        heap.extract
        expect(heap.send(:store).include?(1)).to eq(false)
      end
      it 'correctly sets a new head element' do
        heap.extract
        expect(heap.peek).to eq(2)
      end
      it 'heapifies down to keep the Heap valid' do
        heap.extract
        expect(heap.send(:store)).to eq([2, 4, 3, 7, 5, 6])
      end
      it 'returns the extracted element' do
        expect(heap.extract).to eq(1)
      end
    end
  end

  describe '#merge' do
    let(:heap2) { Heap.new }
    before(:each) { heap2.instance_variable_set(:@store, (1..7).to_a.shuffle) }
    let(:merged_heap) { heap.merge(heap2) }
    it 'returns a new Heap' do
      expect(merged_heap).to be_a(Heap)
      expect(merged_heap).to_not be(heap)
      expect(merged_heap).to_not be(heap2)
    end
    it 'returns a valid heap' do
      expect(valid_heap?(merged_heap)).to eq(true)
    end
    it 'combines both heaps' do
      expect(merged_heap.send(:store).length).to eq(14)
    end
  end
end
