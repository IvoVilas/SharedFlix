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

  @State var bill: BillModel

  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Text(bill.name)

        Text("\(bill.value)")

        Text("\(bill.participants.count)")

        Text("0€ owned")
      }
      .padding()
      .background(Theme.ColorPallete.Gray.v400)
      .shadow(radius: 12)
    }
  }

}

#Preview {
  BillView(
    bill: BillModel(
      id: 0,
      name: "Netlfix",
      value: 14.0,
      cycle: .monthly,
      participants: [
        ParticipantModel(
          id: 0,
          isOwner: true,
          paidUntil: Date(),
          person: PersonModel(
            id: 0,
            name: "Ivo"
          )
        )
      ],
      logs: []
    )
  )
}
