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

        VStack(alignment: .leading, spacing: 0) {
          Text("Participants")
            .applyMediumTextStyle(.xl3, Theme.ColorPallete.Gray.v800)

          VStack(spacing: 0) {
            ForEach(viewModel.participants, id: \.id) { participant in
              Text(participant.person.name)
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
              Text("Add participant")
                .applyBookTextStyle(.xl, Theme.ColorPallete.Gray.v600)
                .padding(all: 8)

              Button(action: {
                viewModel.showPatientsScreen.toggle()
              }) {
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
          .background(Theme.ColorPallete.Gray.v200)
          .clipShape(RoundedRectangle(cornerRadius: 8))
        }
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
