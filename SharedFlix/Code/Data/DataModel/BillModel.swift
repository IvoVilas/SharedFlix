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

}
