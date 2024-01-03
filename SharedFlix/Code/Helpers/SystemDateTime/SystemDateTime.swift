//
//  SystemDateTime.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation
import SwiftDate

public final class SystemDateTime: SystemDateTimeType {

  private let clock: SystemClockType

  public var now: Date {
    return clock.now
  }

  public init() {
    self.clock = SystemClock()
  }

  public init(
    clock: SystemClockType
  ) {
    self.clock = clock
  }

  public func numberOfMonths(
    from initial: Date,
    to final: Date
  ) -> Int {
    let calendar = Calendar.current

    let initialComponents = calendar.dateComponents([.year, .month], from: initial)
    let finalComponents   = calendar.dateComponents([.year, .month], from: final)

    guard
      let initialYear = initialComponents.year,
      let initialMonth = initialComponents.month,
      let finalYear = finalComponents.year,
      let finalMonth = finalComponents.month
    else {
      return 0
    }

    let yearGap  = finalYear - initialYear
    let monthGap = finalMonth - initialMonth

    return yearGap * 12 + monthGap
  }

  public func makeDate(
    day: Int,
    month: Int,
    year: Int
  ) -> Date {
    return Date { component in
      component.year   = year
      component.month  = month
      component.day    = day
      component.hour   = 0
      component.minute = 0
      component.second = 0
    } ?? Date()
  }

}
