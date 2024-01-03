//
//  HomePageView.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import SwiftUI

struct HomePageView: View {

  @ObservedObject var viewModel: HomePageViewModel

  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        Text("SharedFlix")
          .applyMediumTextStyle(.xl6, Theme.ColorPallete.Red.v800)

        ZStack {
          ScrollView {
            VStack(spacing: 24) {
              Spacer().frame(height: 16)

              ForEach(viewModel.bills, id: \.name) { bill in
                BillView(viewModel: bill)
                  .padding(horizontal: 24)
              }
            }
          }
          .blur(radius: viewModel.buttonState == .expanded ? 3 : 0)

          FloatingButtonView(viewModel: viewModel)
            .navigationDestination(isPresented: $viewModel.showBillScreen, destination: { CreateBillView() })
        }
      }
      .background(Theme.ColorPallete.Gray.v900)
    }
  }

}

struct BillView: View {

  @ObservedObject var viewModel: BillViewModel

  var body: some View {
    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
      HStack {
        VStack(alignment: .leading, spacing: 16) {
          Text(viewModel.name)
            .applyMediumTextStyle(.xl, Theme.ColorPallete.Gray.v800)

          Text(viewModel.value)
            .applyBookTextStyle(.l, Theme.ColorPallete.Gray.v700)

          Text(viewModel.participants)
            .applyBookTextStyle(.l, Theme.ColorPallete.Gray.v700)

          Text(viewModel.ownedValue)
            .applyBookTextStyle(.l, Theme.ColorPallete.Gray.v700)
        }

        Spacer()
      }
      .padding(all: 24)
      .background(Theme.ColorPallete.Blue.v600)
      .clipShape(RoundedRectangle(cornerRadius: 20))

      if viewModel.isRemoving {
        Image(systemName: "trash")
          .resizable()
          .padding(all: 4)
          .frame(width: 30, height: 30)
          .background(Theme.ColorPallete.White.v100)
          .foregroundColor(Theme.ColorPallete.Red.v500)
          .clipShape(Circle())
          .offset(x: 15, y: -15)
      }
    }
  }

}

struct CreateBillView: View {

  @FocusState private var nameFieldIsFocused: Bool

  @State private var name: String = ""

  var body: some View {
    VStack {
      TextField(
        "Name:",
        text: $name
      )
      .applyMediumTextStyle(.xl3, Theme.ColorPallete.Gray.v800)
      .focused($nameFieldIsFocused)
      .onSubmit {
        // Do something
      }
      .textInputAutocapitalization(.sentences)
      .autocorrectionDisabled(true)
      .background(Theme.ColorPallete.Gray.v200)

      TextField(
        "Value:",
        text: $name
      )
      .applyMediumTextStyle(.xl3, Theme.ColorPallete.Gray.v800)
      .focused($nameFieldIsFocused)
      .onSubmit {
        // Do something
      }
      .textInputAutocapitalization(.sentences)
      .autocorrectionDisabled(true)
      .background(Theme.ColorPallete.Gray.v200)
    }
  }

}

#Preview {
  let systemDateTime = SystemDateTime()

  return HomePageView(
    viewModel: HomePageViewModel(
      systemDateTime: systemDateTime,
      moc: PersistenceController.preview.container.viewContext
    )
  )
}

#Preview {
  CreateBillView()
}
