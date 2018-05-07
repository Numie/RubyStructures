require 'rspec'
require 'data_structures/stack'

describe Stack do
  let(:stack) { Stack.new }

  describe '#empty?' do
    context 'when Stack is empty' do
      it 'returns true' do
        expect(stack.empty?).to eq(true)
      end
    end

    context 'when Stack is not empty' do
      it 'returns false' do
        stack.send(:store) << 1
        expect(stack.empty?).to eq(false)
      end
    end
  end

  describe '#peek' do
    context 'when Stack is empty' do
      it 'returns nil' do
        expect(stack.peek).to eq(nil)
      end
    end

    context 'when Stack is not empty' do
      it 'returns the top object' do
        stack.send(:store) << 1
        expect(stack.peek).to eq(1)
        stack.send(:store) << 'apple'
        expect(stack.peek).to eq('apple')
      end
    end
  end

  describe '#length' do
    it 'returns the length of the Stack' do
      expect(stack.length).to eq(0)
      stack.send(:store) << 1
      expect(stack.length).to eq(1)
      stack.send(:store) << ['a', 'b']
      expect(stack.length).to eq(2)
    end
  end

  describe '#to_a' do
    it 'converts a Stack to an Array' do
      array = stack.to_a
      expect(array).to be_an(Array)
      expect(array).to eq([])
    end
    it 'maintains order of a Stack' do
      stack.send(:store) << 1
      stack.send(:store) << 'apple'
      expect(stack.to_a).to eq([1, 'apple'])
    end
  end

  describe '#inspect' do
    it 'prints a Stack correctly' do
      stack.send(:store) << 1
      stack.send(:store) << 'apple'
      expect(stack.inspect).to eq([1, 'apple'])
    end
  end

  describe '#==' do
    context 'when two Stacks are equal' do
      it 'returns true' do
        stack2 = Stack.new
        expect(stack == stack2).to eq(true)
        stack.send(:store) << 'apple'
        stack2.send(:store) << 'apple'
        expect(stack == stack2).to eq(true)
      end
    end

    context 'when two Stacks have the same objects but in a different order' do
      it 'returns false' do
        stack.send(:store) << 1
        stack.send(:store) << 'apple'
        stack2 = Stack.new
        stack2.send(:store) << 'apple'
        stack2.send(:store) << 1
        expect(stack == stack2).to eq(false)
      end
    end

    context 'when compared to an Object that is not a Stack' do
      it 'returns false' do
        expect(stack == []).to eq(false)
      end
    end
  end

  describe '#include?' do
    context 'when object is included in a Stack' do
      it 'returns true' do
        stack.send(:store) << 'apple'
        expect(stack.include?('apple')).to eq(true)
      end
    end

    context 'when object is not included in a Stack' do
      it 'returns false' do
        expect(stack.include?('apple')).to eq(false)
      end
    end
  end

  describe '#push' do
    it 'adds an Object to the top of a Stack' do
      stack.push(1)
      stack.push('apple')
      expect(stack.send(:store).last).to eq('apple')
      expect(stack.send(:store).length).to eq(2)
    end
    it 'returns the Stack' do
      expect(stack.push(1)).to be_a(Stack)
    end
  end

  describe '#pop' do
    before(:each) do
      stack.send(:store) << 1
    end
    it 'removes an Object from a Stack' do
      stack.pop
      expect(stack.send(:store)).to_not include(1)
    end
    it 'returns the removed Object' do
      expect(stack.pop).to eq(1)
    end
  end
end
