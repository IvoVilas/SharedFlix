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

    makeData(
      id: 1,
      billName: "Netflix",
      billValue: 14,
      personName: "Ivo",
      moc: viewContext
    )

    makeData(
      id: 2,
      billName: "Prenda",
      billValue: 70,
      personName: "Diana",
      moc: viewContext
    )

    return result
  }()

  static func makeData(
    id: Int64,
    billName: String,
    billValue: Double,
    personName: String,
    moc: NSManagedObjectContext
  ) {
    let bill = BillMO(
      id: id,
      name: billName,
      value: 14,
      cycle: .monthly,
      createdAt: Date(),
      moc: moc
    )!

    let person = PersonMO(
      id: id,
      name: personName,
      moc: moc
    )!

    let participants = [
      ParticipantMO(
        id: id,
        isOwner: false,
        paidUntil: Date(),
        person: person,
        bill: bill,
        moc: moc
      )!
    ]

    bill.participants = Set(participants)

    do {
      try moc.save()
    } catch {
      let nsError = error as NSError

      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }

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
