//
//  CreateBillViewModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 18/12/2023.
//

import Foundation
import SwiftUI
import CoreData

final class CreateBillViewModel: ObservableObject {

  struct TemporaryBill {
    var name: String?
    var value: Double?
    var cycle: CycleType?
    var participants: [ParticipantModel] = []
  }

  struct TemporaryParticipant: InputListItem {
    let person: PersonModel

    var name: String {
      return person.name
    }

    var id: String  {
      return person.name
    }
  }

  let moc: NSManagedObjectContext
  let bill: TemporaryBill

  @Published var showPatientsScreen: Bool

  @ObservedObject var nameInputViewModel: InputFormViewModel
  @ObservedObject var valueInputViewModel: InputFormViewModel
  @ObservedObject var participantsInputViewModel: InputListFormViewModel<TemporaryParticipant>

  let availablePeopleViewModel: AvailablePeopleViewModel

  init(
    moc: NSManagedObjectContext
  ) {
    self.moc  = moc
    self.bill = TemporaryBill()

    self.showPatientsScreen = false

    self.nameInputViewModel = InputFormViewModel(
      title: "Name",
      placeholder: "Insert expense name"
    )

    self.valueInputViewModel = InputFormViewModel(
      title: "Value",
      placeholder: "Insert expense value",
      keyboardType: .decimalPad
    )

    self.participantsInputViewModel = InputListFormViewModel(
      title: "Participants",
      addTitle: "Add participants"
    )

    self.availablePeopleViewModel = AvailablePeopleViewModel(moc: moc)

    participantsInputViewModel.action = { [weak self] in
      self?.showPatientsScreen.toggle()
    }

    availablePeopleViewModel.completion = { [weak self] people in
      guard let self else { return }

      self.showPatientsScreen = false

      self.participantsInputViewModel.setItems(self.makeTemporaryParticipants(people))
    }
  }

  // TODO: isOwner and paidUnit
  func makeTemporaryParticipants(_ people: [PersonModel]) -> [TemporaryParticipant] {
    return people.map { TemporaryParticipant(person: $0) }
  }

  func createBill() -> Bool {
    let bill = BillMO(
      name: nameInputViewModel.input,
      value: Double(valueInputViewModel.input) ?? 0,
      cycle: .monthly,
      createdAt: Date(),
      moc: moc
    )

    for participant in participantsInputViewModel.items {
      // Fetch from database instead of creating
      guard
        let bill,
        let person = PersonMO(
          name: participant.name,
          moc: moc
        ),
        let partcipant = ParticipantMO(
          isOwner: false,
          paidUntil: Date(),
          person: person,
          bill: bill,
          moc: moc
        )
      else {
        continue
      }

      bill.participants.insert(partcipant)
    }

    do {
      try moc.save()
    } catch {
      let nsError = error as NSError

      debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
    }

    return true
  }

}
