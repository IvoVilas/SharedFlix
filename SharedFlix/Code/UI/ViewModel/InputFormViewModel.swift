//
//  InputFormViewModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 18/12/2023.
//

import Foundation
import SwiftUI

protocol InputListItem: Identifiable {

  var name: String { get }

}

final class InputFormViewModel: ObservableObject {

  let title: String
  let placeholder: String
  let keyboardType: UIKeyboardType

  @Published var input: String

  init(
    title: String,
    placeholder: String,
    initialValue: String = "",
    keyboardType: UIKeyboardType = .default
  ) {
    self.title        = title
    self.placeholder  = placeholder
    self.input        = initialValue
    self.keyboardType = keyboardType
  }

}

final class InputListFormViewModel<Item: InputListItem>: ObservableObject {

  let title: String
  let actionTitle: String

  @Published var items: [Item]

  var action: (() -> Void)?

  init(
    title: String,
    addTitle: String,
    items: [Item] = []
  ) {
    self.title       = title
    self.actionTitle = addTitle
    self.items       = items
  }

  func setItems(_ items: [Item]) {
    self.items = items
  }

}
