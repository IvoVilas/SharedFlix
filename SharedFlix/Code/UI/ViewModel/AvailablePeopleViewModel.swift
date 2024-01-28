//
//  AvailablePeopleViewModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 18/12/2023.
//

import Foundation
import SwiftUI
import CoreData

final class AvailablePeopleViewModel: ObservableObject {

  private let limit: Int?
  private let moc: NSManagedObjectContext

  @Published var people: [PersonModel]
  // Normally I would use Set to faster calls
  // But when limited, I want to remove the first and add at the end
  // Because of that I need an array
  @Published var selectedPeople = [String]()

  var completion: (([PersonModel]) -> Void)?

  deinit {
    print("Deleted viewModel")
  }

  init(
    limit: Int?,
    moc: NSManagedObjectContext
  ) {
    self.limit = limit
    self.moc   = moc

    people         = []
    selectedPeople = []

    updateData()
  }

  func isPersonSelected(_ person: PersonModel) -> Bool {
    return selectedPeople.contains(person.id)
  }

  func selectPerson(_ person: PersonModel) {
    if isPersonSelected(person) {
      selectedPeople.removeAll { $0 == person.id }
    } else if let limit, selectedPeople.count >= limit {
      selectedPeople.removeFirst()

      selectedPeople.append(person.id)
    } else {
      selectedPeople.append(person.id)
    }
  }

  func updateData() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")

    do {
      let people = try moc.fetch(fetchRequest) as! [PersonMO]

      self.people = people.compactMap { person in
        return PersonModel(id: person.id, name: person.name)
      }.sorted(by: { $0.name < $1.name })

      self.selectedPeople = self.selectedPeople.filter { [weak self] id in
        guard let self else { return false }

        return self.people.contains { $0.id == id }
      }
    } catch {
      print("Error fetching person data from database")
    }
  }

  func callCompletion() {
    completion?(
      people.filter { [weak self] person in
        guard let self else { return false }

        return self.selectedPeople.contains(person.id)
      }
    )
  }

}
