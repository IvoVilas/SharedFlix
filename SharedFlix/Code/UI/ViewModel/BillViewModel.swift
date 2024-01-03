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

    let valueFirst = String(format: "%.2f€", bill.value)
    let valueSecond: String

    let participants = bill.participants.count
    let participantsWord: String

    switch bill.cycle {
    case .monthly:
      valueSecond = "monthly"

    case .unkown:
      valueSecond = ""
    }

    if participants == 1 {
      participantsWord = "participant"
    } else {
      participantsWord = "participants"
    }

    self.name         = bill.name
    self.value        = "\(valueFirst) \(valueSecond)"
    self.participants = "\(bill.participants.count) \(participantsWord)"
    self.ownedValue   = String(format: "%.2f€ owned", bill.getTotalOwnedValue(using: systemDateTime))

    self.isRemoving = false
  }

}
