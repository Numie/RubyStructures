require 'rspec'
require 'data_structures/queue'

describe Queue do
  let(:queue) { Queue.new }

  describe '#empty?' do
    context 'when Queue is empty' do
      it 'returns true' do
        expect(queue.empty?).to eq(true)
      end
    end

    context 'when Queue is not empty' do
      it 'returns false' do
        queue.send(:store) << 1
        expect(queue.empty?).to eq(false)
      end
    end
  end

  describe '#peek' do
    context 'when Queue is empty' do
      it 'returns nil' do
        expect(queue.peek).to eq(nil)
      end
    end

    context 'when Queue is not empty' do
      it 'returns the object at the front of the Queue' do
        queue.send(:store) << 1
        expect(queue.peek).to eq(1)
        queue.send(:store) << 'apple'
        expect(queue.peek).to eq(1)
      end
    end
  end

  describe '#length' do
    it 'returns the length of the Queue' do
      expect(queue.length).to eq(0)
      queue.send(:store) << 1
      expect(queue.length).to eq(1)
      queue.send(:store) << ['a', 'b']
      expect(queue.length).to eq(2)
    end
  end

  describe '#to_a' do
    it 'converts a Queue to an Array' do
      array = queue.to_a
      expect(array).to be_an(Array)
      expect(array).to eq([])
    end
    it 'maintains order of a Queue' do
      queue.send(:store) << 1
      queue.send(:store) << 'apple'
      expect(queue.to_a).to eq([1, 'apple'])
    end
  end

  describe '#inspect' do
    it 'prints a Queue correctly' do
      queue.send(:store) << 1
      queue.send(:store) << 'apple'
      expect(queue.inspect).to eq([1, 'apple'])
    end
  end

  describe '#==' do
    context 'when two Queues are equal' do
      it 'returns true' do
        queue2 = Queue.new
        expect(queue == queue2).to eq(true)
        queue.send(:store) << 'apple'
        queue2.send(:store) << 'apple'
        expect(queue == queue2).to eq(true)
      end
    end

    context 'when two Queues have the same objects but in a different order' do
      it 'returns false' do
        queue.send(:store) << 1
        queue.send(:store) << 'apple'
        queue2 = Queue.new
        queue2.send(:store) << 'apple'
        queue2.send(:store) << 1
        expect(queue == queue2).to eq(false)
      end
    end

    context 'when compared to an Object that is not a Queue' do
      it 'returns false' do
        expect(queue == []).to eq(false)
      end
    end
  end

  describe '#include?' do
    context 'when object is included in a Queue' do
      it 'returns true' do
        queue.send(:store) << 'apple'
        expect(queue.include?('apple')).to eq(true)
      end
    end

    context 'when object is not included in a Queue' do
      it 'returns false' do
        expect(queue.include?('apple')).to eq(false)
      end
    end
  end

  describe '#enqueue' do
    it 'adds an Object to the back of a Queue' do
      queue.enqueue(1)
      queue.enqueue('apple')
      expect(queue.send(:store).first).to eq(1)
      expect(queue.send(:store).length).to eq(2)
    end
    it 'returns the Queue' do
      expect(queue.enqueue(1)).to be_a(Queue)
    end
  end

  describe '#dequeue' do
    before(:each) do
      queue.send(:store) << 1
    end
    it 'removes an Object from a Queue' do
      queue.dequeue
      expect(queue.send(:store)).to_not include(1)
    end
    it 'returns the removed Object' do
      expect(queue.dequeue).to eq(1)
    end
  end
end
