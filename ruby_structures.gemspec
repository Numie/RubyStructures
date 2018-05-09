Gem::Specification.new do |spec|
  spec.name        = 'ruby_structures'
  spec.version     = '2.0.0'
  spec.date        = '2018-05-08'
  spec.summary     = "Ruby Data Structures"
  spec.description = "Ruby implementations of a Stack, Queue, Linked List, Binary Tree and LRU Cache. More to come!"
  spec.authors     = ["Jason Numeroff"]
  spec.email       = 'jnumeroff@hotmail.com'
  spec.files       = [
                      "lib/ruby_structures.rb",
                      "lib/data_structures/stack.rb",
                      "lib/data_structures/queue.rb",
                      "lib/data_structures/linked_list.rb",
                      "lib/data_structures/binary_tree.rb",
                      "lib/data_structures/lru_cache.rb"
                    ]
  spec.homepage    = 'https://github.com/Numie/RubyStructures'
  spec.license     = 'MIT'
end
