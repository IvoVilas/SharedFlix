//
//  InputFormView.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 15/12/2023.
//

import Foundation
import SwiftUI

struct CreateBillView: View {

  @FocusState private var nameFieldIsFocused: Bool

  @ObservedObject var viewModel: CreateBillViewModel

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        Text("Create new expense")
          .applyMediumTextStyle(.xl4, Theme.ColorPallete.Blue.v500)
          .growHorizontally(alignment: .center)

        VStack(alignment: .leading, spacing: 8) {
          InputFormView(
            viewModel: viewModel.nameInputViewModel
          )

          if let error = viewModel.errors.name {
            Text(error)
              .applyBookTextStyle(.sm, Theme.ColorPallete.Red.v500)
          }
        }

        VStack(alignment: .leading, spacing: 8) {
          InputFormView(
            viewModel: viewModel.valueInputViewModel
          )

          if let error = viewModel.errors.value {
            Text(error)
              .applyBookTextStyle(.sm, Theme.ColorPallete.Red.v500)
          }
        }

        VStack(alignment: .leading, spacing: 8) {
          InputListsFormView(
            viewModel: viewModel.participantsInputViewModel
          )

          if let error = viewModel.errors.participants {
            Text(error)
              .applyBookTextStyle(.sm, Theme.ColorPallete.Red.v500)
          }
        }
      }
      .padding(all: 24)
      .background(Theme.ColorPallete.White.v100)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .sheet(item: $viewModel.showPatientsScreen) { activationItem in
        let viewModel = viewModel.makeAvailablePeopleViewModel(
          activationItem: activationItem
        )

        AvailablePeopleView(viewModel: viewModel)
      }
      .background(Theme.ColorPallete.White.v100)
      .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    .scrollIndicators(.hidden)
  }

}

#Preview {
  ScrollView {
    Spacer().frame(height: 72)

    CreateBillView(
      viewModel: CreateBillViewModel(
        moc: PersistenceController.preview.container.viewContext
      )
    )
  }
  .background(Theme.ColorPallete.Gray.v900)

}
