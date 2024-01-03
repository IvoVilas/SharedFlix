//
//  CreateBillViewModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 18/12/2023.
//

import Foundation
import SwiftUI

final class CreateBillViewModel: ObservableObject {

  @Published var participants: [ParticipantModel]
  @Published var showPatientsScreen: Bool

  @ObservedObject var nameInputViewModel: InputFormViewModel
  @ObservedObject var valueInputViewModel: InputFormViewModel

  init() {
    self.participants       = []
    self.showPatientsScreen = false

    self.nameInputViewModel = InputFormViewModel(
      title: "Name",
      placeholder: "Insert expense name"
    )

    self.valueInputViewModel = InputFormViewModel(
      title: "Value",
      placeholder: "Insert expense value",
      keyboardType: .decimalPad
    )
  }

}