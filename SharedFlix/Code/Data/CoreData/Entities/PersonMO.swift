//
//  PersonMO.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 13/12/2023.
//

import Foundation
import CoreData

class PersonMO: NSManagedObject {

  @NSManaged var id: String
  @NSManaged var name: String

  @NSManaged var participants: Set<ParticipantMO>

  convenience init?(
    id: String = UUID().uuidString,
    name: String,
    moc: NSManagedObjectContext
  ) {
    guard
      let entity = NSEntityDescription.entity(forEntityName: "Person", in: moc)
    else {
      return nil
    }

    self.init(entity: entity, insertInto: moc)

    self.id   = id
    self.name = name

    self.participants = Set<ParticipantMO>()
  }

}
