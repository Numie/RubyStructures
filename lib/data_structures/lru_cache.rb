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

  def find(key)
    @hash[key]
  end

  def include?(key)
    @hash.has_key?(key)
  end

  def append(key, val)
    node = @linked_list.append(key, val)
    @hash[key] = node

    if @size == @max_size
      remove_node(:first)
    else
      @size += 1
    end

    node
  end

  def prepend(key, val)
    node = @linked_list.prepend(key, val)
    @hash[key] = node

    if @size == @max_size
      remove_node(:last)
    else
      @size += 1
    end

    node
  end

  def add_after_key(ref_key, key, val)
    node = @linked_list.add_after_key(ref_key, key, val)
    @hash[key] = node

    if @size == @max_size
      remove_node(:first)
    else
      @size += 1
    end

    node
  end

  def add_before_key(ref_key, key, val)
    node = @linked_list.add_before_key(ref_key, key, val)
    @hash[key] = node

    if @size == @max_size
      remove_node(:last)
    else
      @size += 1
    end

    node
  end

  def remove(key)
    node = self.find(key)
    return nil if node.nil?

    @linked_list.remove(key)
    @hash.delete(key)
    @size -= 1

    node
  end

  private

  def remove_node(position)
    node_key = @linked_list.send(position).send(:key)
    @linked_list.remove(node_key)
    @hash.delete(node_key)
  end

  attr_accessor :max_size, :size
  attr_reader :hash, :linked_list
end
