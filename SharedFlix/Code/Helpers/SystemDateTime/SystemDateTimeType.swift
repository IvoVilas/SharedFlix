//
//  SystemDateTimeType.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation

public protocol SystemDateTimeType {

  var now: Date { get }

  func numberOfMonths(
    from initial: Date,
    to final: Date
  ) -> Int

  func makeDate(
    day: Int,
    month: Int,
    year: Int
  ) -> Date

}
