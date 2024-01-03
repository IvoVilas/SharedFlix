//
//  Persistence.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import CoreData

struct PersistenceController {

  static let shared = PersistenceController()

  static var preview: PersistenceController = {
    let result      = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext

    let bill = BillMO(
      id: 1,
      name: "Netflix",
      value: 14,
      cycle: .monthly,
      createdAt: Date(),
      moc: viewContext
    )!

    let person = PersonMO(
      id: 1,
      name: "Ivo",
      moc: viewContext
    )!

    let participants = [
      ParticipantMO(
        id: 1,
        isOwner: false,
        paidUntil: Date(),
        person: person,
        bill: bill,
        moc: viewContext
      )!
    ]

    bill.participants = Set(participants)

    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError

      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }

    return result
  }()
  
  let container: NSPersistentContainer

  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "SharedFlix")

    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }

    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })

    container.viewContext.automaticallyMergesChangesFromParent = true
  }
  
}
