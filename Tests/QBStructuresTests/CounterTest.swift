//
//  CounterTest.swift
//  qbcps-structures
//
//  Created by Stephen Beitzel on 12/29/25.
//

import Testing

@testable import QBStructures

struct CounterTest {

  @Test func testConvenienceInitializer() async throws {
    let data = [1, 2, 3, 5, 8, 13, 4, 17, 8, 25, 7, 32, 5]
    let counter = Counter(data)
    #expect(counter[1] == 1)
    #expect(counter[5] == 2)
  }

}
