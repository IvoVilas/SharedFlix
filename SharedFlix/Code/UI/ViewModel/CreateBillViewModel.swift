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

  private static let ownerSectionId        = 1
  private static let participantsSectionId = 2

  let moc: NSManagedObjectContext
  let bill: TemporaryBill

  @Published var showPatientsScreen: ParticipantsActivationItem?

  @Published var errors: Errors

  @ObservedObject var nameInputViewModel: InputFormViewModel
  @ObservedObject var valueInputViewModel: InputFormViewModel
  @ObservedObject var participantsInputViewModel: InputListsFormViewModel<TemporaryParticipant>

  var availablePeopleViewModel: AvailablePeopleViewModel?

  var onUserCreatedBill: ((Bool) -> Void)?

  private var observers = Set<AnyCancellable>()

  init(
    moc: NSManagedObjectContext
  ) {
    self.moc    = moc
    self.bill   = TemporaryBill()
    self.errors = Errors()

    self.showPatientsScreen = nil

    self.nameInputViewModel = InputFormViewModel(
      title: "Name",
      placeholder: "Insert expense name"
    )

    self.valueInputViewModel = InputFormViewModel(
      title: "Value",
      placeholder: "Insert expense value",
      keyboardType: .decimalPad
    )

    self.participantsInputViewModel = InputListsFormViewModel(
      title: "Participants"
    )

    setupAvailablePeople()
    setupObservers()
  }

  private func setupAvailablePeople() {
    let sections: [InputListsFormViewModel.SectionType] = [
      .limited(
        .init(
          id: CreateBillViewModel.ownerSectionId,
          title: "Owner",
          actionTitle: "Add owner",
          items: [TemporaryParticipant](),
          action: { [weak self] in
            self?.showPatientsScreen = ParticipantsActivationItem(
              sectionId: CreateBillViewModel.ownerSectionId,
              limit: 1
            )
          }
        ),
        limit: 1
      ),
      .normal(
        .init(
          id: CreateBillViewModel.participantsSectionId,
          title: "Participants",
          actionTitle: "Add participant",
          items: [TemporaryParticipant](),
          action: { [weak self] in
            self?.showPatientsScreen = ParticipantsActivationItem(
              sectionId: CreateBillViewModel.participantsSectionId,
              limit: nil
            )
          }
        )
      )
    ]

    participantsInputViewModel.setSections(sections)
  }

  private func setupObservers() {
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
      participantsInputViewModel.$sections.sink { [weak self] _ in
        self?.errors.participants = nil
      }
    )
  }

  // TODO: isOwner and paidUnit
  func makeTemporaryParticipants(_ people: [PersonModel]) -> [TemporaryParticipant] {
    return people.map { TemporaryParticipant(person: $0) }
  }

  func onUserWantsToCreateBill() {
    if nameInputViewModel.input.isEmpty {
      errors.name = "Name must not be empty"
    }

    if Double(valueInputViewModel.input) == nil {
      errors.value = "Value is not valid"
    }

    if valueInputViewModel.input.isEmpty {
      errors.value = "Value must not be empty"
    }

    if participantsInputViewModel.sections.map({ $0.section.items }).filter({ $0.isEmpty }).count != 0 {
      errors.participants = "Bill must have participants"
    }

    if
      errors.name != nil ||
        errors.value != nil ||
        errors.participants != nil
    {
      return
    }

    if createBill() {
      onUserCreatedBill?(true)

      return
    }
  }

  func onUserWantsToCancel() {
    onUserCreatedBill?(false)
  }

  func createBill() -> Bool {
    guard let bill = BillMO(
      name: nameInputViewModel.input,
      value: Double(valueInputViewModel.input) ?? 0,
      cycle: .monthly,
      createdAt: Date(),
      moc: moc
    ) else {
      return false
    }

    if
      let owner = participantsInputViewModel.getItems(fromSection: CreateBillViewModel.ownerSectionId).first
    {
      // Fetch from database instead of creating
      if
        let person = PersonMO(
          name: owner.name,
          moc: moc
        ),
        let participant = ParticipantMO(
          isOwner: true,
          paidUntil: Date(),
          person: person,
          bill: bill,
          moc: moc
        ) {
        bill.participants.insert(participant)
      }
    }

    for participant in participantsInputViewModel.getItems(fromSection: CreateBillViewModel.participantsSectionId) {
      // Fetch from database instead of creating
      guard
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

  func makeAvailablePeopleViewModel(
    activationItem: ParticipantsActivationItem
  ) -> AvailablePeopleViewModel {
    let viewModel = AvailablePeopleViewModel(
      limit: activationItem.limit,
      moc: moc
    )

    availablePeopleViewModel = viewModel

    viewModel.completion = { [weak self] people in
      guard let self else {
        return
      }

      self.participantsInputViewModel.setItems(
        self.makeTemporaryParticipants(people),
        forSection: activationItem.sectionId
      )

      self.availablePeopleViewModel = nil
      self.showPatientsScreen       = nil
    }

    return viewModel
  }

}

extension CreateBillViewModel {

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

  struct ParticipantsActivationItem: Identifiable {
    let sectionId: Int
    let limit: Int?

    var id: Int { sectionId }
  }

}
