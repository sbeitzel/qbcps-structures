//
//  Counter.swift
//  qbcps-structures
//
//  Created by Stephen Beitzel on 12/29/25.
//

import Foundation

public class Counter<K: Hashable> {
  private var storage: [K: Int] = [:]

  public init() {}

  public convenience init(_ values: any Sequence<K>) {
    self.init()
    for value in values {
      increment(value)
    }
  }

  public subscript(_ key: K) -> Int {
    get { storage[key, default: 0] }
  }

  public var keys: [K] { Array(storage.keys) }

  public func increment(_ key: K, by amount: Int = 1) {
    if let currentValue = storage[key] {
      storage[key] = currentValue + amount
    } else {
      storage[key] = amount
    }
  }
}
