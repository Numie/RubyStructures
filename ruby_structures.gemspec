Gem::Specification.new do |spec|
  spec.name        = 'ruby_structures'
  spec.version     = '2.4.0'
  spec.date        = '2018-05-12'
  spec.summary     = "Ruby Data Structures"
  spec.description = "Ruby implementations of a Stack, Queue, Linked List, Binary Tree, LRU Cache, Heap and Priority Queue. More to come!"
  spec.authors     = ["Jason Numeroff"]
  spec.email       = 'jnumeroff@hotmail.com'
  spec.files       = [
                      "lib/ruby_structures.rb",
                      "lib/data_structures/stack.rb",
                      "lib/data_structures/queue.rb",
                      "lib/data_structures/linked_list.rb",
                      "lib/data_structures/binary_tree.rb",
                      "lib/data_structures/lru_cache.rb",
                      "lib/data_structures/heap.rb",
                      "lib/data_structures/priority_queue.rb"
                    ]
  spec.homepage    = 'https://github.com/Numie/RubyStructures'
  spec.license     = 'MIT'
end
