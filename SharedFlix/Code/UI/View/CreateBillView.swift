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

        InputFormView(
          viewModel: viewModel.nameInputViewModel
        )

        InputFormView(
          viewModel: viewModel.valueInputViewModel
        )

        InputListFormView(
          viewModel: viewModel.participantsInputViewModel
        )
      }
      .padding(all: 24)
      .background(Theme.ColorPallete.White.v100)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .sheet(isPresented: $viewModel.showPatientsScreen) {
        viewModel.availablePeopleViewModel.callCompletion()
      } content: {
        AvailablePeopleView(viewModel: viewModel.availablePeopleViewModel)
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
