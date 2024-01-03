//
//  InputFormViewModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 18/12/2023.
//

import Foundation
import SwiftUI

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
