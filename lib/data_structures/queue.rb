class Queue
  def initialize
    @store = Array.new
  end

  def to_a
    Array.new(@store)
  end

  def to_s
    @store
  end

  def inspect
    @store
  end

  def ==(other_queue)
    return false unless other_queue.is_a?(Queue)
    @store == other_queue.send(:store)
  end

  def empty?
    @store.empty?
  end

  def enqueue(el)
    @store.push(el)
    self
  end

  def <<(el)
    @store << el
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def length
    @store.length
  end

  def include?(el)
    @store.include?(el)
  end

  private

  attr_reader :store
end
