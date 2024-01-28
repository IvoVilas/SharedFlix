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

  @State private var isVisible = false

  var body: some View {
    VStack(spacing: 24) {
      ScrollView {
        Spacer()
          .frame(height: 50)

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
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .growVertically()

      VStack {

        HStack(spacing: 24) {
          Button {
            viewModel.onUserWantsToCancel()
          } label: {
            Image(systemName: "xmark")
              .resizable()
              .padding(all: 16)
              .frame(width: 60, height: 60)
              .background(Theme.ColorPallete.Red.v500)
              .foregroundColor(Theme.ColorPallete.White.v100)
          }
          .clipShape(Circle())
          .offset(x: isVisible ? 0 : 42)

          Button {
            viewModel.onUserWantsToCreateBill()
          } label: {
            Image(systemName: "checkmark")
              .resizable()
              .padding(all: 16)
              .frame(width: 60, height: 60)
              .background(Theme.ColorPallete.Green.v500)
              .foregroundColor(Theme.ColorPallete.White.v100)
          }
          .clipShape(Circle())
          .offset(x: isVisible ? 0 : -42)
        }
      }
    }
    .onAppear {
      withAnimation(
        .spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)
      ) {
        isVisible = true
      }
    }
  }

}

#Preview {
  VStack {
    Spacer().frame(height: 72)

    CreateBillView(
      viewModel: CreateBillViewModel(
        moc: PersistenceController.preview.container.viewContext
      )
    )
  }
  .background(Theme.ColorPallete.Gray.v900)

}
