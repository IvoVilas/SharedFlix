//
//  BillViewModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation
import SwiftUI

final class BillViewModel: ObservableObject {

  @Published var name: String
  @Published var value: String
  @Published var participants: String
  @Published var ownedValue: String

  @Published var isRemoving: Bool

  private var bill: BillModel

  init(
    systemDateTime: SystemDateTimeType,
    bill: BillModel
  ) {
    self.bill = bill

    self.name         = bill.name
    self.value        = BillViewModel.makeBillValueString(bill)
    self.participants = BillViewModel.makeParticipantsString(bill)
    self.ownedValue   = BillViewModel.makeOwnedValueString(bill, systemDateTime: systemDateTime)

    self.isRemoving = false
  }

}

extension BillViewModel {

  private static func makeBillValueString(
    _ bill: BillModel
  ) -> String {
    let value   = bill.value
    let decimal = value.truncatingRemainder(dividingBy: 1)
    
    let secondPart: String

    switch bill.cycle {
    case .monthly:
      secondPart = "monthly"

    case .unkown:
      secondPart = ""
    }

    if decimal == 0 {
      return String(format: "%.0f€ \(secondPart)", value)
    } else {
      return String(format: "%.2f€ \(secondPart)", value)
    }
  }

  private static func makeParticipantsString(
    _ bill: BillModel
  ) -> String {
    let participants = bill.participants.count
    let participantsWord: String

    switch participants {
    case 1:
      participantsWord = "participant"

    default:
      participantsWord = "participants"
    }

    return "\(participants) \(participantsWord)"
  }

  private static func makeOwnedValueString(
    _ bill: BillModel,
    systemDateTime: SystemDateTimeType
  ) -> String {
    let value   = bill.getTotalOwnedValue(using: systemDateTime)
    let decimal = value.truncatingRemainder(dividingBy: 1)

    if decimal == 0 {
      return String(format: "%.0f€ owned", value)
    } else {
      return String(format: "%.2f€ owned", value)
    }
  }

}
