//
//  BillView.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 15/12/2023.
//

import SwiftUI

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

#Preview {
  BillView(
    viewModel: BillViewModel(
      systemDateTime: SystemDateTime(),
      bill: BillModel(
        id: 1,
        name: "Netlfix",
        value: 14,
        cycle: .monthly,
        createdAt: Date(),
        participants: [],
        logs: []
      )
    )
  )
}
