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

  describe '#to_a' do
    let(:array) { (1..7).to_a.shuffle }
    let(:heap2) { Heap.from_array(array) }
    it 'converts a Heap to an array' do
      expect(heap2.to_a).to be_a(Array)
    end
    it 'produces an array in the correct order' do
      expect(heap2.to_a).to eq([1, 2, 3, 4, 5, 6, 7])
    end
  end

  describe '#empty?' do
    context 'when a Heap is empty' do
      it 'returns true' do
        expect(empty_heap.empty?).to eq(true)
      end
    end

    context 'when a Heap is not empty' do
      it 'returns false' do
        expect(heap.empty?).to eq(false)
      end
    end
  end

  describe '#length' do
    it 'returns the length of a Heap' do
      expect(heap.length).to eq(7)
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
    context 'when a non-Array object is passed' do
      it 'raises an error' do
        expect{ heap.insert_mutliple(1) }.to raise_error
      end
    end

    context 'when an Array is passed' do
      let(:array) { (1..7).to_a.shuffle }
      let(:new_heap) { heap.insert_mutliple(array) }
      it 'returns a new Heap' do
        expect(new_heap).to be_a(Heap)
        expect(new_heap).to_not be(heap)
      end
      it 'returns a valid heap' do
        expect(valid_heap?(new_heap)).to eq(true)
      end
      it 'combines the heap and array' do
        expect(new_heap.send(:store).length).to eq(14)
      end
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

  describe '#find' do
    context 'when a Heap is empty' do
      it 'returns nil' do
        expect(empty_heap.find(1)).to eq(nil)
      end
    end

    context 'when a Heap does not include an element' do
      it 'returns nil' do
        expect(heap.find(0)).to eq(nil)
        expect(heap.find(8)).to eq(nil)
      end
    end

    context 'when a Heap does include an element' do
      it 'returns the element' do
        expect(heap.find(7)).to eq(7)
      end
    end
  end

  describe '#include?' do
    context 'when a Heap does not include an element' do
      it 'returns false' do
        expect(heap.include?(8)).to eq(false)
      end
    end

    context 'when a Heap does include an element' do
      it 'returns true' do
        expect(heap.include?(7)).to eq(true)
      end
    end
  end

  describe '#merge' do
    let(:heap2) { Heap.new }
    before(:each) { heap2.instance_variable_set(:@store, (1..7).to_a.shuffle) }
    let(:merged_heap) { heap.merge(heap2) }
    context 'when a non-Heap object is passed' do
      it 'raises an error' do
        expect{ heap.merge([]) }.to raise_error
      end
    end
    context 'when a Heap is passed' do
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
end
