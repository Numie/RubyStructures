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

More to come...

## Stack

A Stack is a LIFO (last in, first out) container.

### Stack API

1. `to_a`
1. `to-s`
1. `inspect`
1. `==`
1. `empty?`
1. `push(el)`
1. `<<(el)`
1. `pop`
1. `peek`
1. `length`
1. `include?(el)`

## Queue

A Queue is a FIFO (first in, first out) container.

### Queue API

1. `to_a`
1. `to-s`
1. `inspect`
1. `==`
1. `empty?`
1. `enqueue(el)`
1. `<<(el)`
1. `dequeue`
1. `peek`
1. `length`
1. `include?(el)`

## Linked List

A Linked List is an ordered collection of items, or nodes, where the ordering is determined by links between the nodes. The Ruby Structures implementation of a Linked List is doubly linked, meaning that each node has a link to the node after it as well as the node preceding it.

### Linked List API

1. `to_a`
1. `to_s`
1. `inspect`
1. `empty?`
1. `first`
1. `last`
1. `append(val)`
1. `prepend(val)`
1. `find(val)`
1. `include?(val)`
1. `remove(val)`
1. `update(val)`
1. `each(&prc)`
1. `map(&prc)`
