//
//  SystemClock.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation

public struct SystemClock: SystemClockType {

  public var now: Date {
    return Date()
  }

  public init() { }

}
