Gem::Specification.new do |spec|
  spec.name        = 'ruby_structures'
  spec.version     = '2.5.0'
  spec.date        = '2018-05-17'
  spec.summary     = "Ruby Data Structures"
  spec.description = "Ruby implementations of a Stack, Queue, Linked List, Binary Tree, LRU Cache, Heap, Priority Queue, Graph and Weighted Graph. More to come!"
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
                      "lib/data_structures/priority_queue.rb",
                      "lib/data_structures/graph.rb",
                      "lib/data_structures/directed_graph.rb",
                      "lib/data_structures/weighted_graph.rb",
                      "lib/data_structures/weighted_directed_graph.rb"
                    ]
  spec.homepage    = 'https://github.com/Numie/RubyStructures'
  spec.license     = 'MIT'
end
