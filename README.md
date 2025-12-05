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


[Advent of Code]: https://adventofcode.com
