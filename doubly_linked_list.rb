class DoublyLinkedList
  def initialize(head=nil)
    @head = head
  end
end

class Node
  def initialize(data=nil, next_node=nil, prev_node=nil)
    @data = data
    @next = next_node
    @prev = prev_node
  end
end
