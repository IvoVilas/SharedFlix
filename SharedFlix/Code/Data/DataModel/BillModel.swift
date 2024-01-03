//
//  BillModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation

struct BillModel {

  let id: String
  let name: String
  let value: Double
  let cycle: CycleType
  let createdAt: Date
  
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

  static func from(_ entity: BillMO) -> BillModel {
    return BillModel(
      id: entity.id,
      name: entity.name,
      value: entity.value,
      cycle: CycleType.from(entity.cycleId),
      createdAt: entity.createdAt,
      participants: entity.participants.map { ParticipantModel.from($0, billCreatedAt: entity.createdAt) },
      logs: entity.logs.map { LogModel.from($0) }
    )
  }

}
