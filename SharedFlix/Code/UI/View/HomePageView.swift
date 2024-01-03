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
    VStack(spacing: 0) {
      Text("SharedFlix")
        .applyMediumTextStyle(.xl6, Theme.ColorPallete.Red.v800)

      ScrollView {
        VStack {
          ForEach(viewModel.bills, id: \.name) { bill in
            BillView(viewModel: bill)
              .padding(horizontal: 24)
          }
        }
      }
    }
  }

}

struct BillView: View {

  @ObservedObject var viewModel: BillViewModel

  var body: some View {
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
