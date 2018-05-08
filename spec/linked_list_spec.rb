require 'rspec'
require 'data_structures/linked_list'

describe LinkedList do
  let(:linked_list) { LinkedList.new }

  describe '#empty?' do
    context 'when LinkedList is empty' do
      it 'returns true' do
        expect(linked_list.empty?).to eq(true)
      end
    end

    context 'when LinkedList is not empty' do
      let(:node) { double('node') }
      it 'returns false' do

      end
    end
  end

  describe '#append' do
    it 'includes the appended value' do
      linked_list.append('apple')
      expect(linked_list.include?('apple')).to eq(true)
    end
    it 'appends a Node to the end of the LinkedList' do
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
    it 'appends a Node to the start of the LinkedList' do
      linked_list.prepend(1)
      expect(linked_list.first.send(:val)).to eq(1)
    end
    it 'returns the prepended Node' do
      expect(linked_list.prepend(2)).to be_a(Node)
    end
  end
end
