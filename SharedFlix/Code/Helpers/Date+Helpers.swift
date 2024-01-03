//
//  Date+Helpers.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation

extension Date {

  public var startOfDay: Date {
    return Calendar.current.startOfDay(for: self)
  }

  public var endOfDay: Date {
    var components    = DateComponents()
    components.day    = 1
    components.second = -1

    return Calendar.current.date(byAdding: components, to: startOfDay)!
  }

}
