//
//  BillMO.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 13/12/2023.
//

import Foundation
import CoreData

class BillMO: NSManagedObject {

  @NSManaged var id: Int64
  @NSManaged var name: String
  @NSManaged var value: Double
  @NSManaged var cycleId: Int16

  @NSManaged var participants: Set<ParticipantMO>
  @NSManaged var logs: Set<LogMO>

  convenience init?(
    id: Int64,
    name: String,
    value: Double,
    cycle: CycleType,
    moc: NSManagedObjectContext
  ) {
    guard
      let entity = SharedFlixDatabase.EntityDescription.bill(moc)
    else {
      return nil
    }

    self.init(entity: entity, insertInto: moc)

    self.id      = id
    self.name    = name
    self.value   = value
    self.cycleId = cycle.id

    self.participants = Set<ParticipantMO>()
    self.logs         = Set<LogMO>()
  }

}

