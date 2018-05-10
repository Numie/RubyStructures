require 'rspec'
require 'data_structures/lru_cache'

describe LRUCache do
  let(:lru_cache) { LRUCache.new(3) }
  let(:empty_lru_cache) { LRUCache.new(3) }
  before(:each) do
    lru_cache.append(1, 1)
    lru_cache.append(2, 'apple')
    lru_cache.append(3, 2)
  end

  describe '#to_a' do
    it 'converts LRU Cache Nodes into an array' do
      expect(lru_cache.to_a).to eq([1, 'apple', 2])
    end
  end

  describe '#empty?' do
    context 'when an LRU Cache is empty' do
      it 'returns true' do
        expect(empty_lru_cache.empty?).to eq(true)
      end
    end

    context 'when an LRU Cache is not empty' do
      it 'returns false' do
        expect(lru_cache.empty?).to eq(false)
      end
    end
  end

  describe '#first' do
    it 'returns the first node' do
      node = lru_cache.first
      expect(node.send(:key)).to eq(1)
    end
  end

  describe '#last' do
    it 'returns the last node' do
      node = lru_cache.last
      expect(node.send(:key)).to eq(3)
    end
  end

  describe '#find' do
    context 'when a key does not exist in the cache' do
      it 'returns nil' do
        expect(lru_cache.find(4)).to eq(nil)
      end
    end

    context 'when a key does exist in the cache' do
      it 'returns the correct Node' do
        node = lru_cache.find(2)
        expect(node.send(:val)).to eq('apple')
      end
    end
  end

  describe '#include?' do
    context 'when a key does not exist in the cache' do
      it 'returns false' do
        expect(lru_cache.include?(4)).to eq(false)
      end
    end

    context 'when a key doe exist in the cache' do
      it 'returns true' do
        expect(lru_cache.include?(1)).to eq(true)
      end
    end
  end

  describe '#append' do
    context 'when an LRU Cache size is less than its max size' do
      before(:each) do
        empty_lru_cache.append(4, 'orange')
      end
      it 'adds a Node to the end of the cache' do
        expect(empty_lru_cache.last.send(:val)).to eq('orange')
      end
      it 'increases the size of the cache' do
        expect(empty_lru_cache.send(:size)).to eq(1)
      end
    end

    context 'when an LRU Cache is at its max size' do
      before(:each) do
        lru_cache.append(4, 'orange')
      end
      it 'adds a Node to the end of the cache' do
        expect(lru_cache.last.send(:val)).to eq('orange')
      end
      it 'removes the first Node of the cache' do
        expect(lru_cache.first.send(:val)).to eq('apple')
      end
      it 'maintains its size' do
        expect(lru_cache.send(:size)).to eq(3)
      end
    end
  end

  describe '#prepend' do
    context 'when an LRU Cache size is less than its max size' do
      before(:each) do
        empty_lru_cache.prepend(4, 'orange')
      end
      it 'adds a Node to the beginning of the cache' do
        expect(empty_lru_cache.first.send(:val)).to eq('orange')
      end
      it 'increases the size of the cache' do
        expect(empty_lru_cache.send(:size)).to eq(1)
      end
    end

    context 'when an LRU Cache is at its max size' do
      before(:each) do
        lru_cache.prepend(4, 'orange')
      end
      it 'adds a Node to the beginning of the cache' do
        expect(lru_cache.first.send(:val)).to eq('orange')
      end
      it 'removes the last Node of the cache' do
        expect(lru_cache.last.send(:val)).to eq('apple')
      end
      it 'maintains its size' do
        expect(lru_cache.send(:size)).to eq(3)
      end
    end
  end

  describe '#add_after_key' do
    context 'when there is no Node with a given ref key' do
      it 'raises an error' do
        expect{ lru_cache.add_after_key(4, 5, 'orange') }.to raise_error
      end
    end

    context 'when there is a Node with a given ref key' do
      it 'adds a node after the ref key' do
        lru_cache.add_after_key(3, 4, 'orange')
        expect(lru_cache.last.send(:val)).to eq('orange')
      end
      it 'returns the added Node' do
        expect(lru_cache.add_after_key(3, 4, 'orange').send(:val)).to eq('orange')
      end
    end

    context 'when an LRU Cache size is less than its max size' do
      it 'increases the size of the cache' do
        empty_lru_cache.append(1, 'apple')
        empty_lru_cache.add_after_key(1, 2, 'orange')
        expect(empty_lru_cache.send(:size)).to eq(2)
      end
    end

    context 'when an LRU Cache size is at its max size' do
      before(:each) { lru_cache.add_after_key(3, 4, 'orange') }
      it 'removes the first Node of the cache' do
        expect(lru_cache.first.send(:val)).to eq('apple')
      end
      it 'maintains its size' do
        expect(lru_cache.send(:size)).to eq(3)
      end
    end
  end

  describe '#add_before_key' do
    context 'when there is no Node with a given ref key' do
      it 'raises an error' do
        expect{ lru_cache.add_before_key(4, 5, 'orange') }.to raise_error
      end
    end

    context 'when there is a Node with a given ref key' do
      it 'adds a node before the ref key' do
        lru_cache.add_before_key(1, 4, 'orange')
        expect(lru_cache.first.send(:val)).to eq('orange')
      end
      it 'returns the added Node' do
        expect(lru_cache.add_before_key(3, 4, 'orange').send(:val)).to eq('orange')
      end
    end

    context 'when an LRU Cache size is less than its max size' do
      it 'increases the size of the cache' do
        empty_lru_cache.append(1, 'apple')
        empty_lru_cache.add_before_key(1, 2, 'orange')
        expect(empty_lru_cache.send(:size)).to eq(2)
      end
    end

    context 'when an LRU Cache size is at its max size' do
      before(:each) { lru_cache.add_before_key(1, 4, 'orange') }
      it 'removes the last Node of the cache' do
        expect(lru_cache.last.send(:val)).to eq('apple')
      end
      it 'maintains its size' do
        expect(lru_cache.send(:size)).to eq(3)
      end
    end
  end


  describe '#remove' do
    context 'when a key does not exist in teh cache' do
      it 'returns nil' do
        expect(lru_cache.remove(4)).to eq(nil)
      end
    end

    context 'when a key does exist in the cache' do
      it 'removes the correct Node from the cache' do
        lru_cache.remove(2)
        expect(lru_cache.include?(2)).to eq(false)
      end
      it 'decreases the size of the cache' do
        lru_cache.remove(2)
        expect(lru_cache.send(:size)).to eq(2)
      end
      it 'returns the removed node' do
        node = lru_cache.remove(2)
        expect(node.send(:val)).to eq('apple')
      end
    end
  end
end
