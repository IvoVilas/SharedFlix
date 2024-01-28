//
//  InputFormView.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 18/12/2023.
//

import Foundation
import SwiftUI

// MARK: InputFormView
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

// MARK: InputListFormView
struct InputListFormView<Item: InputListItem>: View {

  @ObservedObject var viewModel: InputListFormViewModel<Item>

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(viewModel.title)
        .applyMediumTextStyle(.xl3, Theme.ColorPallete.Gray.v800)

      VStack(spacing: 0) {
        ForEach(viewModel.items, id: \.id) { item in
          FormItemView(name: item.name)
        }

        FormActionView(
          title: viewModel.actionTitle,
          action: viewModel.action
        )
      }
      .scrollIndicators(.hidden)
      .background(Theme.ColorPallete.Gray.v200)
      .clipShape(RoundedRectangle(cornerRadius: 8))
    }
  }

}

// MARK: InputListsFormView
struct InputListsFormView<Item: InputListItem>: View {

  @ObservedObject var viewModel: InputListsFormViewModel<Item>

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(viewModel.title)
        .applyMediumTextStyle(.xl3, Theme.ColorPallete.Gray.v800)

      VStack(spacing: 16) {
        ForEach(viewModel.sections) { section in
          FormSectionView(
            section: section
          )
        }
        .id(viewModel.forceUpdate)
      }
      .scrollIndicators(.hidden)
    }
  }

}

// MARK: FormSectionView
private struct FormSectionView<Item: InputListItem>: View {

  @State var section: InputListsFormViewModel<Item>.SectionType

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text(section.section.title)
        .applyMediumTextStyle(.xl, Theme.ColorPallete.Gray.v800)

      VStack(spacing: 0) {
        ForEach(
          Array(section.section.items.enumerated()),
          id: \.offset
        ) { index, item in
          switch section {
          case .normal:
            FormItemView(name: item.name)

          case .limited(_, let limit):
            FormItemView(
              name: item.name,
              hasDivider: index < limit - 1
            )
          }
        }

        switch section {
        case .normal(let section):
          FormActionView(
            title: section.actionTitle,
            action: section.action
          )

        case .limited(let section, let limit):
          if section.items.count < limit {
            FormActionView(
              title: section.actionTitle,
              action: section.action
            )
          }
        }
      }
      .background(Theme.ColorPallete.Gray.v200)
      .clipShape(RoundedRectangle(cornerRadius: 8))
    }
  }

}

// MARK: FormItemView
private struct FormItemView: View {

  let name: String
  let hasDivider: Bool

  init(
    name: String,
    hasDivider: Bool = true
  ) {
    self.name       = name
    self.hasDivider = hasDivider
  }

  var body: some View {
    VStack(spacing: 0) {
      Text(name)
        .applyBookTextStyle(.xl2, Theme.ColorPallete.Gray.v700)
        .growHorizontally(alignment: .leading)
        .padding(all: 8)

      if hasDivider {
        LineView(
          color: Theme.ColorPallete.Gray.v600,
          lineWidth: 2
        )
        .padding(horizontal: 4)
        .background(Theme.ColorPallete.Gray.v200)
      }
    }
  }

}

// MARK: FormActionView
private struct FormActionView: View {

  let title: String
  let action: (() -> Void)?

  var body: some View {
    HStack(spacing: 0) {
      Text(title)
        .applyBookTextStyle(.xl, Theme.ColorPallete.Gray.v600)
        .padding(all: 8)

      Button {
        action?()
      } label: {
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

}

// MARK: Preview
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
        addTitle: "Add participant",
        items: [
          CreateBillViewModel.TemporaryParticipant(
            person: PersonModel(
              id: "1",
              name: "Diana"
            )
          ),
          CreateBillViewModel.TemporaryParticipant(
            person: PersonModel(
              id: "2",
              name: "Diogo"
            )
          )
        ]
      )
    )

    InputListsFormView<CreateBillViewModel.TemporaryParticipant>(
      viewModel: InputListsFormViewModel(
        title: "Participants",
        sections: [
          .limited(
            InputListsFormViewModel.Section(
              id: 1,
              title: "Owner",
              actionTitle: "Add owner",
              items: [
                CreateBillViewModel.TemporaryParticipant(
                  person: PersonModel(
                    id: "1",
                    name: "Ivo"
                  )
                )
              ]
            ),
            limit: 1
          ),
          .normal(
            InputListsFormViewModel.Section(
              id: 2,
              title: "Participants",
              actionTitle: "Add participants",
              items: [
                CreateBillViewModel.TemporaryParticipant(
                  person: PersonModel(
                    id: "1",
                    name: "Diana"
                  )
                ),
                CreateBillViewModel.TemporaryParticipant(
                  person: PersonModel(
                    id: "2",
                    name: "Diogo"
                  )
                )
              ]
            )
          )
        ]
      )
    )
  }
  .padding(horizontal: 24)
}
