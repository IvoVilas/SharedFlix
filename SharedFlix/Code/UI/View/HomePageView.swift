//
//  HomePageView.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import SwiftUI

struct HomePageView: View {

  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }

}

struct BillView: View {

  @ObservedObject var viewModel: BillViewModel

  var body: some View {
    ScrollView {
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
    .padding(horizontal: 36)
  }

}

#Preview {
  let systemDateTime = SystemDateTime()

  return BillView(
    viewModel: BillViewModel(
      systemDateTime: systemDateTime,
      bill: BillModel(
        id: 0,
        name: "Netflix",
        value: 14.0,
        cycle: .monthly,
        participants: [
          ParticipantModel(
            id: 0,
            isOwner: true,
            paidUntil: systemDateTime.makeDate(day: 31, month: 10, year: 2023),
            person: PersonModel(
              id: 0,
              name: "Ivo"
            )
          )
        ],
        logs: []
      )
    )
  )
}
