//
//  BillModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation

struct BillModel {

  let id: Int64
  let name: String
  let value: Double
  let cycle: CycleType
  let participants: [ParticipantModel]
  let logs: [LogModel]

  func getTotalOwnedValue(
    using systemDateTime: SystemDateTimeType = SystemDateTime()
  ) -> Double {
    let individualValue = value / Double(participants.count)

    return participants.map {
      $0.getOwnedValue(paying: individualValue, cycle: cycle, using: systemDateTime)
    }.reduce(0, +)
  }

}
