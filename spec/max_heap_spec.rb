require 'rspec'
require 'data_structures/max_heap'

describe MaxHeap do
  let(:heap) { MaxHeap.new }
  let(:empty_heap) { MaxHeap.new }
  before(:each) { heap.instance_variable_set(:@store, [7, 6, 5, 4, 3, 2, 1]) }

  def valid_heap?(heap)
    heap.send(:store).each_index do |idx|
      parent_idx = heap.send(:parent_idx, idx)
      next if parent_idx < 0
      return false if heap.send(:store)[parent_idx] < heap.send(:store)[idx]
    end
    true
  end

  describe '::from_array' do
    let(:array) { (1..7).to_a.shuffle }
    it 'converts an array into a Max Heap' do
      expect(MaxHeap.from_array(array)).to be_a(MaxHeap)
    end
    it 'correctly heapifies the array' do
      expect(valid_heap?(MaxHeap.from_array(array))).to eq(true)
    end
  end

  describe '#to_a' do
    let(:array) { (1..7).to_a.shuffle }
    let(:heap2) { MaxHeap.from_array(array) }
    it 'converts a Max Heap to an array' do
      expect(heap2.to_a).to be_a(Array)
    end
    it 'produces an array in the correct order' do
      expect(heap2.to_a).to eq([7, 6, 5, 4, 3, 2, 1])
    end
    it 'preserves the original Max Heap' do
      heap2.to_a
      expect(heap2.send(:store).length).to eq(7)
    end
  end

  describe '#empty?' do
    context 'when a Max Heap is empty' do
      it 'returns true' do
        expect(empty_heap.empty?).to eq(true)
      end
    end

    context 'when a Max Heap is not empty' do
      it 'returns false' do
        expect(heap.empty?).to eq(false)
      end
    end
  end

  describe '#length' do
    it 'returns the length of a Max Heap' do
      expect(heap.length).to eq(7)
    end
  end

  describe '#peek' do
    context 'when a Max Heap is empty' do
      it 'returns nil' do
        expect(empty_heap.peek).to eq(nil)
      end
    end

    context 'when a Max Heap is not empty' do
      it 'returns the head value of the Heap' do
        expect(heap.peek).to eq(7)
      end
    end
  end

  describe '#insert' do
    it 'increases the size of the Max Heap' do
      heap.insert(7)
      expect(heap.send(:store).length).to eq(8)
    end
    it 'adds the given element to the Max Heap' do
      heap.insert(7)
      expect(heap.send(:store).count(7)).to eq(2)
    end
    it 'heapifies up to keep the Max Heap valid' do
      heap.insert(7)
      expect(heap.send(:store)).to eq([7, 7, 5, 6, 3, 2, 1, 4])
    end
    it 'returns the given element' do
      expect(heap.insert(7)).to eq(7)
    end
  end

  describe '#insert_multiple' do
    context 'when a non-Array object is passed' do
      it 'raises an error' do
        expect{ heap.insert_mutliple(7) }.to raise_error
      end
    end

    context 'when an Array is passed' do
      let(:array) { (1..7).to_a.shuffle }
      let(:new_heap) { heap.insert_mutliple(array) }
      it 'returns a new Max Heap' do
        expect(new_heap).to be_a(MaxHeap)
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
    context 'when a Max Heap is empty' do
      it 'returns nil' do
        expect(empty_heap.extract).to eq(nil)
      end
    end
    context 'when a Max Heap is not empty' do
      it 'decreases the size of the Heap' do
        heap.extract
        expect(heap.send(:store).length).to eq(6)
      end
      it 'removes the head element of the Heap' do
        heap.extract
        expect(heap.send(:store).include?(7)).to eq(false)
      end
      it 'correctly sets a new head element' do
        heap.extract
        expect(heap.peek).to eq(6)
      end
      it 'heapifies down to keep the Max Heap valid' do
        heap.extract
        expect(heap.send(:store)).to eq([6, 4, 5, 1, 3, 2])
      end
      it 'returns the extracted element' do
        expect(heap.extract).to eq(7)
      end
    end
  end

  describe '#find' do
    context 'when a Max Heap is empty' do
      it 'returns nil' do
        expect(empty_heap.find(7)).to eq(nil)
      end
    end

    context 'when a Max Heap does not include an element' do
      it 'returns nil' do
        expect(heap.find(0)).to eq(nil)
        expect(heap.find(8)).to eq(nil)
      end
    end

    context 'when a Max Heap does include an element' do
      it 'returns the element' do
        expect(heap.find(7)).to eq(7)
      end
    end
  end

  describe '#include?' do
    context 'when a Max Heap does not include an element' do
      it 'returns false' do
        expect(heap.include?(8)).to eq(false)
      end
    end

    context 'when a Max Heap does include an element' do
      it 'returns true' do
        expect(heap.include?(7)).to eq(true)
      end
    end
  end

  describe '#merge' do
    let(:heap2) { MaxHeap.new }
    before(:each) { heap2.instance_variable_set(:@store, (1..7).to_a.shuffle) }
    let(:merged_heap) { heap.merge(heap2) }
    context 'when a non-Heap object is passed' do
      it 'raises an error' do
        expect{ heap.merge([]) }.to raise_error
      end
    end
    context 'when a Max Heap is passed' do
      it 'returns a new Max Heap' do
        expect(merged_heap).to be_a(MaxHeap)
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
