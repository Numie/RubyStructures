require 'rspec'
require 'data_structures/linked_list'

describe LinkedList do
  let(:linked_list) { LinkedList.new }
  let(:node) { double('node') }
  let(:prc) { Proc.new { |n| n } }

  describe '#to_a' do
    before(:each) do
      linked_list.append(1)
      linked_list.append('apple')
      linked_list.append(2)
    end

    it 'converts a Linked List to an array' do
      expect(linked_list.to_a).to eq([1, 'apple', 2])
    end
  end

  describe '#inspect' do
    context 'when Linked List is empty' do
      it 'prints an empty Linked List' do
        expect(linked_list.inspect).to eq('-')
      end
    end

    context 'when Linked List is not empty' do
      before(:each) do
        linked_list.append(1)
        linked_list.append('apple')
        linked_list.append(2)
      end

      it 'prints each Node in the Linked List' do
        expect(linked_list.inspect).to eq('1 -> apple -> 2')
      end
    end
  end

  describe '#empty?' do
    context 'when Linked List is empty' do
      it 'returns true' do
        expect(linked_list.empty?).to eq(true)
      end
    end

    context 'when Linked List is not empty' do
      it 'returns false' do
        linked_list.instance_variable_get(:@head).instance_variable_set(:@next, node)
        expect(linked_list.empty?).to eq(false)
      end
    end
  end

  describe '#first' do
    context 'when Linked List is empty' do
      it 'returns nil' do
        expect(linked_list.first).to eq(nil)
      end
    end

    context 'when Linked List is not empty' do
      it 'returns the first Node' do
        linked_list.instance_variable_get(:@head).instance_variable_set(:@next, node)
        expect(linked_list.first).to eq(node)
      end
    end
  end

  describe '#last' do
    context 'when Linked List is empty' do
      it 'returns nil' do
        expect(linked_list.last).to eq(nil)
      end
    end

    context 'when Linked List is not empty' do
      it 'returns the last Node' do
        linked_list.instance_variable_get(:@tail).instance_variable_set(:@prev, node)
        expect(linked_list.last).to eq(node)
      end
    end
  end

  describe '#append' do
    it 'includes the appended value' do
      linked_list.append('apple')
      expect(linked_list.include?('apple')).to eq(true)
    end
    it 'appends a Node to the end of the Linked List' do
      linked_list.append(1)
      expect(linked_list.last.send(:val)).to eq(1)
    end
    it 'returns the appended Node' do
      expect(linked_list.append(2)).to be_a(Node)
    end
  end

  describe '#prepend' do
    it 'includes the prepended value' do
      linked_list.prepend('apple')
      expect(linked_list.include?('apple')).to eq(true)
    end
    it 'appends a Node to the start of the Linked List' do
      linked_list.prepend(1)
      expect(linked_list.first.send(:val)).to eq(1)
    end
    it 'returns the prepended Node' do
      expect(linked_list.prepend(2)).to be_a(Node)
    end
  end

  describe '#find' do
    before(:each) do
      linked_list.append(1)
      linked_list.append('apple')
      linked_list.append(2)
    end

    context 'when a value does not exist in a Linked List' do
      it 'returns nil' do
        expect(linked_list.find('orange')).to eq(nil)
      end
    end

    context 'when a value does exist in a Linked List' do
      it 'returns a Node' do
        expect(linked_list.find(2)).to be_a(Node)
      end
      it 'returns the Node with the correct value' do
        found_node = linked_list.find(2)
        expect(found_node.instance_variable_get(:@val)).to eq(2)
      end
    end
  end

  describe '#include?' do
    context 'when a Linked List does not include a value' do
      it 'returns false' do
        expect(linked_list.include?(1)).to eq(false)
      end
    end

    context 'when a Linked List does include a value' do
      it 'returns true' do
        linked_list.append(1)
        expect(linked_list.include?(1)).to eq(true)
      end
    end
  end

  describe '#update' do
    before(:each) do
      linked_list.append(1)
      linked_list.append('apple')
      linked_list.append(2)
    end

    context 'when a Linked List does not include an old value' do
      it 'raises an error' do
        expect{ linked_list.update(3, 'orange') }.to raise_error
      end
    end

    context 'when a Linked List does include an old value' do
      it 'updates the value' do
        linked_list.update('apple', 'orange')
        expect(linked_list.include?('apple')).to eq(false)
        expect(linked_list.include?('orange')).to eq(true)
      end
    end
  end

  describe '#remove' do
    before(:each) do
      linked_list.append(1)
      linked_list.append('apple')
      linked_list.append(2)
    end

    context 'when a Linked List does not include a value' do
      it 'returns nil' do
        expect(linked_list.remove('orange')).to eq(nil)
      end
    end

    context 'when a Linked List does include a value' do
      it 'removes the value' do
        linked_list.remove('apple')
        expect(linked_list.include?('apple')).to eq(false)
      end
      it 'returns the removed Node' do
        returned_node = linked_list.remove('apple')
        expect(returned_node.instance_variable_get(:@val)).to eq('apple')
      end
    end
  end

  describe '#each' do
    before(:each) do
      linked_list.append(1)
      linked_list.append('apple')
      linked_list.append(2)
    end
    it 'yields each Node to a block' do
      node1 = linked_list.first
      node2 = node1.send(:next)
      node3 = node2.send(:next)
      expect{ |prc| linked_list.each(&prc) }.to yield_successive_args(node1, node2, node3)
    end
    it 'returns the Linked List' do
      expect(linked_list.each(&prc)).to eq(linked_list)
    end
  end
end
