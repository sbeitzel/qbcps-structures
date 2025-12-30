//
//  LinkedList.swift
//  qbcps-structures
//
//  Created by Stephen Beitzel on 12/26/25.
//

import Testing
@testable import QBStructures

struct LinkedListTest {

  @Test func testContainsValues() async throws {
    let list = LinkedList<Int>()
    list.push(1)
    list.push(2)
    list.push(4)

    #expect(list.count == 3)
    let elements: [Int] = .init(list)
    #expect(elements == [4, 2, 1])

    list.pop()
    list.pop()
    #expect(list.count == 1)
    #expect(list.pop() == 1)
  }

}
