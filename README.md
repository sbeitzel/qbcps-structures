# QBStructures (aka qbcps-structures)

I'm always happy when I can export the job of problem-solving to a data structure. Often, the structures are already
part of the programming language I'm using, but sometimes I find myself needing to create something custom. The result
is this library: when I wind up wanting a generic data structure to solve my specific problem, I migrate the
implementation over here.

## Data Structures

### DiscontinuousRange

Introduced in the first version of this library, I found this helpful in solving the Day 5 challenge in the 2025
[Advent of Code]. `DiscontinuousRange` collects together a bunch of ranges, combining any that overlap, and it
responds to queries about whether a given element is contained within its ranges.

### LinkedList

Sometimes, I want to hold a bunch of things in order and I want constant time for insert and delete operations.
Sounds like a job for a linked list! So far, it just does basic stack operations (push, pop, peek). It's a singly
linked list, so there's only one way traversal. But it also keeps track of how many elements it has, so that getting
the `count` is also a constant time operation. And it keeps track of the tail element, so appending at the end is also
constant time.

### Counter

This is based on the Python `collections.Counter` class. Basically, it's a `Dictionary` whose keys map to `Int` values
to keep track of how many times that key has been incremented.

[Advent of Code]: https://adventofcode.com
