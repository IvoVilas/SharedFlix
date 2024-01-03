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

  private let moc: NSManagedObjectContext

  @Published var people: [PersonModel]
  @Published var selectedPeople = Set<String>()

  var completion: (([PersonModel]) -> Void)?

  init(
    moc: NSManagedObjectContext
  ) {
    self.moc = moc

    people         = []
    selectedPeople = []

    updateData()
  }

  func isPersonSelected(_ person: PersonModel) -> Bool {
    return selectedPeople.contains(person.id)
  }

  func selectPerson(_ person: PersonModel) {
    if isPersonSelected(person) {
      selectedPeople.remove(person.id)
    } else {
      selectedPeople.insert(person.id)
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
