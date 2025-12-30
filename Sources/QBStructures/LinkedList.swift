//
//  LinkedList.swift
//  qbcps-structures
//
//  Created by Stephen Beitzel on 12/25/25.
//

import Foundation

public class LinkedList<Element> {
  class Node {
    let value: Element
    var next: Node?

    init(value: Element, next: Node?) {
      self.value = value
      self.next = next
    }
  }

  var head: Node?
  var tail: Node?
  var nodeCount: Int = 0

  public init() {
    head = nil
    tail = nil
  }

  /// adds the provided value to the front of the list
  public func push(_ value: Element) {
    let newNode = Node(value: value, next: head)
    head = newNode
    if tail == nil {
      tail = newNode
    }
    nodeCount += 1
  }

  public func append(_ value: Element) {
    let newNode = Node(value: value, next: nil)
    if let tailNode = tail {
      tailNode.next = newNode
    } else {
      // list is empty
      head = newNode
      tail = newNode
    }
    nodeCount += 1
  }

  public func peek() -> Element? {
    head?.value
  }

  /// removes the head element of the list and returns its value
  @discardableResult
  public func pop() -> Element? {
    guard let headNode = head else { return nil }
    head = headNode.next
    if head == nil {
      tail = nil
    }
    nodeCount -= 1
    return headNode.value
  }
}

extension LinkedList: Sequence {
  public var isEmpty: Bool { return head == nil }

  public var count: Int {
    return nodeCount
  }

  public func makeIterator() -> Iterator {
    Iterator(head)
  }

  public struct Iterator: IteratorProtocol {
    var current: LinkedList<Element>.Node?

    init(_ head: LinkedList<Element>.Node?) {
      current = head
    }

    public mutating func next() -> Element? {
      defer { current = current?.next }
      return current?.value
    }
  }
}
