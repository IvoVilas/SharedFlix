//
//  PersonMO.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 13/12/2023.
//

import Foundation
import CoreData

class PersonMO: NSManagedObject {

  @NSManaged var id: Int64
  @NSManaged var name: String

  @NSManaged var participants: Set<ParticipantMO>

  convenience init?(
    id: Int64,
    name: String,
    moc: NSManagedObjectContext
  ) {
    guard
      let entity = SharedFlixDatabase.EntityDescription.person(moc)
    else {
      return nil
    }

    self.init(entity: entity, insertInto: moc)

    self.id   = id
    self.name = name

    self.participants = Set<ParticipantMO>()
  }

}
