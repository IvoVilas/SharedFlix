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
    NavigationView {
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
      .toolbar(.hidden, for: .automatic)
      .sheet(isPresented: $viewModel.showPatientsScreen) {
        // On dismiss code
      } content: {
        Text("Hello world!")
      }
    }
    .background(Theme.ColorPallete.White.v100)
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }

}

#Preview {

  ScrollView {
    Spacer().frame(height: 72)

    CreateBillView(viewModel: CreateBillViewModel())
  }
  .background(Theme.ColorPallete.Gray.v900)

}
