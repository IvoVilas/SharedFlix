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
    VStack(alignment: .leading, spacing: 8) {
      Text(viewModel.title)
        .applyMediumTextStyle(.xl3, Theme.ColorPallete.Gray.v800)

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

struct InputListFormView<Item: InputListItem>: View {

  @ObservedObject var viewModel: InputListFormViewModel<Item>

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(viewModel.title)
        .applyMediumTextStyle(.xl3, Theme.ColorPallete.Gray.v800)

      VStack(spacing: 0) {
        ForEach(viewModel.items, id: \.id) { item in
          Text(item.name)
            .applyBookTextStyle(.xl2, Theme.ColorPallete.Gray.v700)
            .growHorizontally(alignment: .leading)
            .padding(all: 8)

          LineView(
            color: Theme.ColorPallete.Gray.v600,
            lineWidth: 2
          )
          .padding(horizontal: 4)
          .background(Theme.ColorPallete.Gray.v200)
        }

        HStack {
          Text(viewModel.actionTitle)
            .applyBookTextStyle(.xl, Theme.ColorPallete.Gray.v600)
            .padding(all: 8)

          Button(action: { viewModel.action?() }) {
            HStack {
              Spacer()

              Image(systemName: "plus")
                .resizable()
                .padding(all: 2)
                .frame(width: 20, height: 20)
                .foregroundColor(Theme.ColorPallete.Gray.v600)
                .padding(all: 8)
            }
          }
        }
      }
      .scrollIndicators(.hidden)
      .background(Theme.ColorPallete.Gray.v200)
      .clipShape(RoundedRectangle(cornerRadius: 8))
    }
  }

}

#Preview {
  VStack(spacing: 24) {
    InputFormView(
      viewModel: InputFormViewModel(
        title: "Input",
        placeholder: "Write your input"
      )
    )

    InputListFormView<CreateBillViewModel.TemporaryParticipant>(
      viewModel: InputListFormViewModel(
        title: "Participants",
        addTitle: "Add participant"
      )
    )
  }
  .padding(horizontal: 24)
}
