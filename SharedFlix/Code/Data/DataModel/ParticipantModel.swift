//
//  ParticipantModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation

struct ParticipantModel {

  let id: Int64
  let isOwner: Bool
  let paidUntil: Date
  
  let person: PersonModel

  func getOwnedValue(
    paying value: Double,
    cycle: CycleType,
    using systemDateTime: SystemDateTimeType = SystemDateTime()
  ) -> Double {
    switch cycle {
    case .monthly:
      let ownedMonths = systemDateTime.numberOfMonths(from: paidUntil, to: systemDateTime.now)

      return Double(ownedMonths) * value

    case .unkown:
      return value
    }
  }

  static func from(
    _ entity: ParticipantMO,
    billCreatedAt date: Date
  ) -> ParticipantModel {
    return ParticipantModel(
      id: entity.id,
      isOwner: entity.isOwner,
      paidUntil: entity.paidUntil ?? date,
      person: PersonModel.from(entity.person)
    )
  }

}
