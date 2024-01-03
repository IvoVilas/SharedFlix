//
//  InputFormView.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 18/12/2023.
//

import Foundation
import SwiftUI

struct InputFormView: View {

  @FocusState private var inputFieldIsFocused: Bool

  @ObservedObject var viewModel: InputFormViewModel

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text(viewModel.title)
        .applyMediumTextStyle(.xl3, Theme.ColorPallete.Gray.v800)

      Spacer()
        .frame(height: 8)

      TextField(
        viewModel.placeholder,
        text: $viewModel.input
      )
      .applyBookTextStyle(.xl2, Theme.ColorPallete.Gray.v800)
      .keyboardType(viewModel.keyboardType)
      .focused($inputFieldIsFocused)
      .onSubmit {
        // Do something
      }
      .textInputAutocapitalization(.sentences)
      .autocorrectionDisabled(true)
      .padding(all: 8)
      .background(Theme.ColorPallete.Gray.v200)
      .clipShape(RoundedRectangle(cornerRadius: 8))
    }
  }

}

#Preview {
  InputFormView(
    viewModel: InputFormViewModel(
      title: "Input",
      placeholder: "Write your input"
    )
  )
  .padding(horizontal: 24)
}
