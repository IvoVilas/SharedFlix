//
//  CreateBillViewModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 18/12/2023.
//

import Foundation
import SwiftUI
import CoreData
import Combine

final class CreateBillViewModel: ObservableObject {

  struct Errors {
    var name: String?
    var value: String?
    var participants: String?
  }

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

  @Published var errors: Errors

  @ObservedObject var nameInputViewModel: InputFormViewModel
  @ObservedObject var valueInputViewModel: InputFormViewModel
  @ObservedObject var participantsInputViewModel: InputListFormViewModel<TemporaryParticipant>

  let availablePeopleViewModel: AvailablePeopleViewModel

  private var observers = Set<AnyCancellable>()

  init(
    moc: NSManagedObjectContext
  ) {
    self.moc    = moc
    self.bill   = TemporaryBill()
    self.errors = Errors()

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

    observers.insert(
      nameInputViewModel.$input.sink { [weak self] _ in
        self?.errors.name = nil
      }
    )

    observers.insert(
      valueInputViewModel.$input.sink { [weak self] _ in
        self?.errors.value = nil
      }
    )

    observers.insert(
      participantsInputViewModel.$items.sink { [weak self] _ in
        self?.errors.participants = nil
      }
    )
  }

  // TODO: isOwner and paidUnit
  func makeTemporaryParticipants(_ people: [PersonModel]) -> [TemporaryParticipant] {
    return people.map { TemporaryParticipant(person: $0) }
  }

  func onUserWantsToCreateBill() -> Bool {
    if nameInputViewModel.input.isEmpty {
      errors.name = "Name must not be empty"
    }

    if Double(valueInputViewModel.input) == nil {
      errors.value = "Value is not valid"
    }

    if valueInputViewModel.input.isEmpty {
      errors.value = "Value must not be empty"
    }

    if participantsInputViewModel.items.isEmpty {
      errors.participants = "Bill must have participants"
    }

    if
      errors.name != nil ||
        errors.value != nil ||
        errors.participants != nil
    {
      return false
    }

    return createBill()
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
