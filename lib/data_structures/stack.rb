class Stack
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

  def ==(other_stack)
    return false unless other_stack.is_a?(Stack)
    @store == other_stack.send(:store)
  end

  def empty?
    @store.empty?
  end

  def push(el)
    @store.push(el)
    self
  end

  def <<(el)
    @store << el
  end

  def pop
    @store.pop
  end

  def peek
    @store.last
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
