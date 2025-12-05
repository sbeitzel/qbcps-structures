//
//  Test.swift
//  QBStructures
//
//  Created by Stephen Beitzel on 12/5/25.
//

import Testing

@testable import QBStructures

struct Test {
  
  @Test func testOverlappingCombine() async throws {
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
  
  @Test func testDiscontinuity() async throws {
    let first = 0..<5
    let second = 6..<10
    var dRange = DiscontinuousRange<Int>()
    dRange.add(range: first)
    dRange.add(range: second)
    #expect(dRange.ranges.count == 2)
    #expect(dRange.contains(4))
    #expect(dRange.contains(6))
    #expect(!dRange.contains(5))
  }

  @Test func testCountElements() async throws {
    let first = 0..<5
    let second = 6..<10
    var dRange = DiscontinuousRange<Int>()
    dRange.add(range: first)
    dRange.add(range: second)
    #expect(dRange.count == 9)
  }

  @Test func testVariadicInitializer() async throws {
    let first = 0..<10
    let second = 8..<15
    let dRange = DiscontinuousRange(second, first)
    #expect(dRange.ranges.count == 1)
    #expect(dRange.contains(7)) // only in first
    #expect(dRange.contains(14)) // only in second
    #expect(dRange.contains(9)) // in the intersection
  }
}

