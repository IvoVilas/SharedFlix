//
//  CycleType.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 13/12/2023.
//

import Foundation

enum CycleType {

  case monthly

  var id: Int16 {
    switch self {
    case .monthly:
      return 1
    }
  }

  static func from(_ value: Int16) -> CycleType? {
    switch value {
    case 1:
      return .monthly

    default:
      return nil
    }
  }

}
