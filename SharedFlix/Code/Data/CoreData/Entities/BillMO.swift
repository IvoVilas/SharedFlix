//
//  BillMO.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 13/12/2023.
//

import Foundation
import CoreData

class BillMO: NSManagedObject {

  @NSManaged var id: String
  @NSManaged var name: String
  @NSManaged var value: Double
  @NSManaged var cycleId: Int16
  @NSManaged var createdAt: Date

  @NSManaged var participants: Set<ParticipantMO>
  @NSManaged var logs: Set<LogMO>

  convenience init?(
    id: String = UUID().uuidString,
    name: String,
    value: Double,
    cycle: CycleType,
    createdAt: Date,
    participants: [ParticipantMO] = [],
    logs: [LogMO] = [],
    moc: NSManagedObjectContext
  ) {
    guard
      let entity = NSEntityDescription.entity(forEntityName: "Bill", in: moc)
    else {
      return nil
    }

    self.init(entity: entity, insertInto: moc)

    self.id        = id
    self.name      = name
    self.value     = value
    self.cycleId   = cycle.id
    self.createdAt = createdAt

    self.participants = Set(participants)
    self.logs         = Set(logs)
  }

}

