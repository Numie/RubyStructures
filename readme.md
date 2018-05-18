# Ruby Structures

Ruby implementations of common data structures.

[![Gem Version](https://badge.fury.io/rb/ruby_structures.svg)](https://badge.fury.io/rb/ruby_structures)

## Installation & Usage

Install Ruby Structures:
```
gem install ruby_structures
```
Or add it to your Gemfile:
```
gem 'ruby_structures'
```
Require Ruby Structures in your file:
```
require 'ruby_structures'
```

## Available Data Structures

* Stack
* Queue
* Linked List
* Binary Tree
* LRU Cache
* Heap
* Priority Queue
* Graph
* Weighted Graph

More to come...

## Stack

A Stack is a LIFO (last in, first out) container.

### Stack API

1. `#to_a`
1. `#==`
1. `#empty?`
1. `#push(el)`
1. `#<<(el)`
1. `#pop`
1. `#peek`
1. `#length`
1. `#include?(el)`

## Queue

A Queue is a FIFO (first in, first out) container.

### Queue API

1. `#to_a`
1. `#==`
1. `#empty?`
1. `#enqueue(el)`
1. `#<<(el)`
1. `#dequeue`
1. `#peek`
1. `#length`
1. `#include?(el)`

## Linked List

A Linked List is an ordered collection of items, or nodes, where the ordering is determined by links between the nodes. The Ruby Structures implementation of a Linked List is doubly linked, meaning that each node has a link to the node after it as well as the node preceding it.

### Linked List API

1. `#to_a`
1. `#empty?`
1. `#length`
1. `#first`
1. `#last`
1. `#append(key, val)`
1. `#prepend(key, val)`
1. `#add_after_key(ref_key, key, val)`
1. `#add_before_key(ref_key, key, val)`
1. `#find_by_key(key)`
1. `#find_by_val(val)`
1. `#include_key?(key)`
1. `#include_val?(val)`
1. `#remove(key)`
1. `#update(key, new_val)`
1. `#each(&prc)`

## Binary Tree

A Binary Tree is a tree in which each Node may have a maximum of two children.

### Binary Tree API

1. `::from_array(array)`
1. `#depth_first_search`
1. `#breadth_first_search`

## LRU Cache

An LRU Cache is an ordered container that combines a Hash and a Linked List to provide insertion, deletion and inclusion methods in constant time.

### LRU Cache API

1. `#to_a`
1. `#empty?`
1. `#length`
1. `#first`
1. `#last`
1. `#append(key, val)`
1. `#prepend(key, val)`
1. `#add_after_key(ref_key, key, val)`
1. `#add_before_key(ref_key, key, val)`
1. `#remove(key)`
1. `#find(key)`
1. `#include?(key)`

## Heap

A Heap is a tree-based data structure that adheres to the Heap principle. Ruby Structures implements a Min Heap, which means that each parent element in the heap is of lesser value than each of its child elements. A Min Heap always has access to its minimum element.

### Heap API

1. `::from_array(array)`
1. `#to_a`
1. `#empty?`
1. `#length`
1. `#peek`
1. `#insert(el)`
1. `#insert_multiple(array)`
1. `#extract`
1. `#find(el)`
1. `#include?(el)`
1. `#merge(other_heap)`

## Priority Queue

A Priority Queue is a specialized queue where each element has a 'priority' attribute. A Priority Queue always has access to its highest priority element.

### Priority Queue API

1. `::from_array(array)`
1. `::from_hash(hash)`
1. `#to_a`
1. `#empty?`
1. `#length`
1. `#peek`
1. `#insert(data, priority)`
1. `#extract`
1. `#find(data)`
1. `#include?(data)`
1. `#merge(other_queue)`

## Graph

A Graph is a set of vertices and a set vertex pairs, or edges, that connect vertices to one another. Ruby Structures implements both an Undirected Graph (unordered edge pairs) and a Directed Graph (ordered edge pairs).

### Graph & Directed Graph API

1. `#add_vertex(id)`
1. `#delete_vertex(id)`
1. `#create_edge(id1, id2)`
1. `#delete_edge(id1, id2)`
1. `#adjacent?(id1, id2)`
1. `#adjacent_vertices(id)`
1. `#depth_first_search(target_id, start_id, &prc)`
1. `#breadth_first_search(target_id, start_id, &prc)`

## Weighted Graph

A Weighted Graph is a Graph in which each edge is assigned a weight. Ruby Structures implements both the undirected and directed varieties of a Weighted Graph.

### Weighted Graph & Weighted Directed Graph API

1. `#add_vertex(id)`
1. `#delete_vertex(id)`
1. `#create_edge(id1, id2, weight)`
1. `#delete_edge(id1, id2, weight)`
1. `#adjacent?(id1, id2)`
1. `#adjacent_vertices(id)`
1. `#highest_weight_adjacent(id)`
1. `#lowest_weight_adjacent(id)`
