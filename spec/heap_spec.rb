require 'rspec'
require 'data_structures/heap'

describe Heap do
  let(:heap) { Heap.new }
  let(:empty_heap) { Heap.new }
  before(:each) { heap.instance_variable_set(:@store, [1, 2, 3, 4, 5, 6, 7]) }

  describe '::from_array' do
    let(:array) { [6, 9, 3, 1, 8, 5] }
    it 'converts an array into a Heap' do
      expect(Heap.from_array(array)).to be_a(Heap)
    end
    it 'correctly heapifies the array' do
      expect(Heap.from_array(array).send(:store)).to eq([1, 6, 3, 9, 8, 5])
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
end
