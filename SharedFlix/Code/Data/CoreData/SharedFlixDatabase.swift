//
//  SharedFlixDatabase.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 13/12/2023.
//

import Foundation
import CoreData

final class SharedFlixDatabase {

  private let coreDataDb: (NSPersistentContainer, NSManagedObjectContext)

  init(inMemoryDatabase: Bool = false) {
    let dataBaseName = "FindProfessionalDatabase"

    let databaseUrl: URL

    if inMemoryDatabase {
      databaseUrl = URL(fileURLWithPath: "/dev/null")
    } else {
      databaseUrl = SharedFlixDatabase.databaseUrl(name: dataBaseName)
    }

    guard
      let dataModelUrl       = Bundle.main.url(forResource: dataBaseName, withExtension: "momd"),
      let managedObjectModel = NSManagedObjectModel(contentsOf: dataModelUrl)
    else {
      fatalError("Dev error unable to find core data models")
    }

    coreDataDb = SharedFlixDatabase.createAndLoadPersistentContainer(
      name: dataBaseName,
      model: managedObjectModel,
      databaseUrl: databaseUrl
    )
  }

}

// MARK: - SharedFlixDatabase.EntityName
extension SharedFlixDatabase {

  enum EntityName: String, CaseIterable {
    case bill        = "Bill"
    case participant = "Participant"
    case person      = "Person"
    case log         = "Log"
  }

}

// MARK: - SharedFlixDatabase.EntityDescription
extension SharedFlixDatabase {

  struct EntityDescription {

    static func bill(_ moc: NSManagedObjectContext) -> NSEntityDescription? {
      entity(.bill, moc)
    }

    static func participant(_ moc: NSManagedObjectContext) -> NSEntityDescription? {
      entity(.participant, moc)
    }

    static func person(_ moc: NSManagedObjectContext) -> NSEntityDescription? {
      entity(.person, moc)
    }

    static func log(_ moc: NSManagedObjectContext) -> NSEntityDescription? {
      entity(.log, moc)
    }

    static func entity(_ entity: SharedFlixDatabase.EntityName, _ moc: NSManagedObjectContext) -> NSEntityDescription? {
      NSEntityDescription.entity(forEntityName: entity.rawValue, in: moc)
    }

  }

}

// MARK: - SharedFlixDatabase.FetchRequest
extension SharedFlixDatabase {

  struct FetchRequest {

    static func bill(_ moc: NSManagedObjectContext) -> NSFetchRequest<BillMO>? {
      fetchRequest(.bill)
    }

    static func participant(_ moc: NSManagedObjectContext) -> NSFetchRequest<ParticipantMO>? {
      fetchRequest(.participant)
    }

    static func person(_ moc: NSManagedObjectContext) -> NSFetchRequest<PersonMO>? {
      fetchRequest(.person)
    }

    static func log(_ moc: NSManagedObjectContext) -> NSFetchRequest<LogMO>? {
      fetchRequest(.log)
    }

    static func fetchRequest<T: NSManagedObject>(_ entity: SharedFlixDatabase.EntityName) -> NSFetchRequest<T> {
      NSFetchRequest<T>(entityName: entity.rawValue)
    }

  }

}


extension SharedFlixDatabase {

  public static func createAndLoadPersistentContainer(
    name: String,
    model: NSManagedObjectModel,
    databaseUrl: URL
  ) -> (NSPersistentContainer, NSManagedObjectContext) {
    let persistentContainer = NSPersistentContainer(
      name: name,
      managedObjectModel: model
    )

    let storeDescription = NSPersistentStoreDescription(url: databaseUrl)

    storeDescription.type                                 = NSSQLiteStoreType
    storeDescription.shouldMigrateStoreAutomatically      = true
    storeDescription.shouldInferMappingModelAutomatically = true
    storeDescription.shouldAddStoreAsynchronously         = false

    persistentContainer.persistentStoreDescriptions = [
      storeDescription
    ]

    persistentContainer.loadPersistentStores { (_, error) in
      if let error = error {
        print("Unable to start database \(name) at \(databaseUrl) with error \(error)")
      } else {
        print("Started database \(name) at \(databaseUrl)")
      }
    }

    persistentContainer.viewContext.automaticallyMergesChangesFromParent = true

    return (persistentContainer, persistentContainer.newBackgroundContext())
  }

  public static func databaseUrl(name: String) -> URL {
    if let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let databaseDirectory = documentsUrl.appendingPathComponent(name, isDirectory: true)

      try? FileManager.default.createDirectory(at: databaseDirectory, withIntermediateDirectories: true, attributes: nil)

      return databaseDirectory.appendingPathComponent("\(name).sqlite")
    }

    return URL(fileURLWithPath: "/dev/null")
  }

}
