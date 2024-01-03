//
//  AvailablePeopleView.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 18/12/2023.
//

import SwiftUI

struct AvailablePeopleView: View {

  @ObservedObject var viewModel: AvailablePeopleViewModel

  var body: some View {
    NavigationView {
      List(viewModel.people, id: \.id) { person in
        HStack {
          Text(person.name)

          Spacer()

          if viewModel.isPersonSelected(person) {
            Image(systemName: "checkmark")
              .resizable()
              .padding(all: 2)
              .frame(width: 20, height: 20)
              .background(Theme.ColorPallete.White.v100)
              .foregroundColor(Theme.ColorPallete.Green.v500)
          }
        }
        .contentShape(Rectangle())
        .onTapGesture {
          viewModel.selectPerson(person)
        }
      }
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button(action: { viewModel.callCompletion() }) {
            Image(systemName: "plus")
              .resizable()
              .padding(all: 2)
              .frame(width: 24, height: 24)
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button(action: { viewModel.callCompletion() }) {
            Text("Done")
          }
        }
      }
    }
  }

}

#Preview {
  AvailablePeopleView(
    viewModel: AvailablePeopleViewModel(
      moc: PersistenceController.preview.container.viewContext
    )
  )
}
