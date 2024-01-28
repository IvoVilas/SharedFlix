//
//  HomePageView.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import SwiftUI

struct HomePageView: View {

  @ObservedObject var viewModel: HomePageViewModel

  @State private var shouldShake = false
  @State private var isExpanded  = false
  @State private var isRemoving  = false
  @State private var isCreating  = false
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        Text("SharedFlix")
          .applyMediumTextStyle(.xl6, Theme.ColorPallete.Red.v800)
          .growHorizontally(alignment: .center)

        ZStack {
          ScrollView {
            VStack(spacing: 24) {
              Spacer().frame(height: 16)

              ForEach(viewModel.bills, id: \.name) { bill in
                BillView(viewModel: bill)
                  .padding(horizontal: 24)
                  .shake(shouldShake: shouldShake)
              }
            }
          }
          .refreshable { viewModel.updateData() }
          .blur(radius: isExpanded || isCreating ? 3 : 0)

          if isCreating {
            CreateBillView(viewModel: viewModel.makeCreateBillViewModel())
              .padding(horizontal: 24)
              .shadow(radius: 5)
          }

          FloatingButtonView(viewModel: viewModel)
            .opacity(isCreating ? 0 : 1)
            .animation(
              .linear(duration: isCreating ? 0.1 : 0.3),
              value: isCreating
            )
        }
      }
      .background(Theme.ColorPallete.Gray.v900)
      .assign($isExpanded, to: viewModel.isExpanded)
      .assign($isRemoving, to: viewModel.isRemoving)
      .assign($isCreating, to: viewModel.isCreating)
      .onChange(of: isRemoving) { oldValue, newValue in
        if oldValue != newValue {
          withAnimation(.linear(duration: 0.1).repeatCount(3, autoreverses: true)) {
            self.shouldShake.toggle()
          }
        }
      }
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
