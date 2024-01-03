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
  let paidUntil: Date?
  let person: PersonModel

}
