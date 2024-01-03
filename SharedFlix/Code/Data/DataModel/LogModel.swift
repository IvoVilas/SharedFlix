//
//  LogModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation

struct LogModel {

  let id: Int64
  let date: Date
  let value: Double
  
  static func from(_ entity: LogMO) -> LogModel {
    return LogModel(
      id: entity.id,
      date: entity.date,
      value: entity.value
    )
  }

}
