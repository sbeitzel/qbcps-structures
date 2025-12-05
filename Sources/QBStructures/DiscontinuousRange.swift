//
//  DiscontinuousRange.swift
//  QBStructures
//
//  Created by Stephen Beitzel on 12/5/25.
//

import Foundation

fileprivate extension Range {
  func combined(with other: Range) -> [Range] {
    if self.overlaps(other) {
      let minValue = Swift.min(self.lowerBound, other.lowerBound)
      let maxValue = Swift.max(self.upperBound, other.upperBound)
      return [minValue..<maxValue]
    } else {
      return [self, other]
    }
  }
}

/// Zero or more `Range`s of some element type that is `Strideable`.
/// Currently only useful for answering the questions, "Is *element* contained
/// in the defined range(s)?" and "How many elements can fit in the defined
/// ranges?"
/// An obvious to-do item would be to implement some kind of enumeration
/// capability, so that one might define a `DiscontinuousRange` and then
/// write code to iterate over the whole thing:
/// ```
/// var disjointInts = DiscontinuousRange<Int>()
/// disjointInts.add(range: 0..<5)
/// disjointInts.add(range: 7..<10)
/// for number in disjointInts {
///    print("\(number) ")
/// }
/// ```
/// ...and expect to see printed `0 1 2 3 7 8 9 ` This is not yet implemented,
/// but it would be cool. Implicit in that implementation, by the way, would be
/// keeping the ranges sorted so that it wouldn't matter what order you added the
/// ranges in.
public struct DiscontinuousRange<T: Strideable> {
  var ranges: [Range<T>]

  public var count: T.Stride {
    ranges.reduce(0, { $0 + $1.lowerBound.distance(to: $1.upperBound) })
  }

  public init() {
    ranges = []
  }

  public init(_ sourceRanges: Range<T>...) {
    ranges = []
    for range in sourceRanges {
      add(range: range)
    }
  }

  public mutating func remove(range: Range<T>) {
    ranges.removeAll(where: { $0 == range })
  }

  public mutating func add(range: Range<T>) {
    var overlappingRanges: [Range<T>] = []
    for existingRange in ranges {
      if existingRange.overlaps(range) {
        overlappingRanges.append(existingRange)
      }
    }
    ranges.removeAll(where: { overlappingRanges.contains($0) })
    // now, we are dealing with the case where we know that combining
    // results in a single range
    // start with the range
    var combinedRange = range
    // combine with each overlap
    for overlappingRange in overlappingRanges {
      combinedRange = combinedRange.combined(with: overlappingRange).first!
    }
    ranges.append(combinedRange)
  }

  public func contains(_ element: T) -> Bool {
    for range in ranges {
      if range.contains(element) { return true }
    }
    return false
  }
}

extension DiscontinuousRange where T.Stride: SignedInteger {
  public mutating func add(closedRange: ClosedRange<T>) {
    add(range: Range(closedRange))
  }
}

extension DiscontinuousRange: Sendable where T: Sendable {}
