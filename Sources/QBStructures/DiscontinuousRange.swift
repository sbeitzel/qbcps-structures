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
public struct DiscontinuousRange<T: Strideable> {
  var ranges: [Range<T>] = []

  public var count: T.Stride {
    ranges.reduce(0, { $0 + $1.lowerBound.distance(to: $1.upperBound) })
  }

  public init() { }

  public init(_ sourceRanges: Range<T>...) {
    for range in sourceRanges {
      add(range: range)
    }
  }

  public mutating func remove(range: Range<T>) {
    // NOTE: we don't do a sort here because the `add` implementation
    // guarantees that every range insertion results in an ordered list.
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
    // now, we are dealing with the case where we know that combining results in a single range
    // start with the range
    var combinedRange = range
    // combine with each overlap
    for overlappingRange in overlappingRanges {
      combinedRange = combinedRange.combined(with: overlappingRange).first!
    }
    ranges.append(combinedRange)
    // last thing we do, we have to sort the ranges
    ranges.sort(by: { lhs, rhs in
      // we already know that the ranges don't overlap
      // so all we have to do is compare their beginnings
      return lhs.lowerBound < rhs.lowerBound
    })
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

extension DiscontinuousRange: Sequence where T: Strideable, T.Stride: SignedInteger {
  public func makeIterator() -> some IteratorProtocol<T> {
    DRIterator(ranges)
  }

  // for each range in the list of ranges, we get the iterator
  // if the iterator.next returns nil, we go to the next range
  // if there are no more ranges, just return nil
  struct DRIterator: IteratorProtocol {
    typealias Element = T

    let ranges: [Range<T>]
    var currentRangeIndex: Int = 0
    var currentIterator: IndexingIterator<Range<T>>?

    init(_ ranges: [Range<T>]) {
      // first, we collect all the ranges
      self.ranges = ranges
      if !ranges.isEmpty {
        currentIterator = ranges.first!.makeIterator()
      }
    }

    mutating func next() -> T? {
      guard currentIterator != nil else { return nil }
      if let nextElement = currentIterator?.next() {
        return nextElement
      }
      // okay, there was no next element
      // so, we go to the next range
      currentRangeIndex += 1
      if currentRangeIndex < ranges.count {
        currentIterator = ranges[currentRangeIndex].makeIterator()
        return currentIterator?.next()
      } else {
        currentIterator = nil
      }
      return nil
    }
  }
}
