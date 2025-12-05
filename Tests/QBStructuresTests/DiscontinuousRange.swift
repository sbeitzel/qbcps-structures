//
//  Test.swift
//  QBStructures
//
//  Created by Stephen Beitzel on 12/5/25.
//

import Testing

@testable import QBStructures

struct Test {

    @Test func overlappingCombine() async throws {
      let first = 0..<10
      let second = 8..<15
      var dRange = DiscontinuousRange<Int>()
      dRange.add(range: first)
      dRange.add(range: second)
      #expect(dRange.ranges.count == 1)
      #expect(dRange.contains(7)) // only in first
      #expect(dRange.contains(14)) // only in second
      #expect(dRange.contains(9)) // in the intersection
    }

}
