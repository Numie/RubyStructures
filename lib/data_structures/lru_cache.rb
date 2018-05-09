require_relative 'linked_list'

class LRUCache
  def initialize(max_size)
    @max_size = max_size
    @size = 0
    @hash = {}
    @linked_list = LinkedList.new
  end

  def to_a
    @linked_list.to_a
  end

  def empty?
    @size == 0
  end

  def first
    @linked_list.first
  end

  def last
    @linked_list.last
  end

  private

  attr_accessor :max_size, :size
  attr_reader :hash, :linked_list
end
