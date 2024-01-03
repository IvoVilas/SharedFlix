//
//  ParticipantMO.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 13/12/2023.
//

import Foundation
import CoreData

class ParticipantMO: NSManagedObject {

  @NSManaged var id: Int64
  @NSManaged var isOwner: Bool
  @NSManaged var paidUntil: Date?

  @NSManaged var person: PersonMO
  @NSManaged var bill: BillMO

  convenience init?(
    id: Int64,
    isOwner: Bool,
    paidUntil: Date?,
    person: PersonMO,
    bill: BillMO,
    moc: NSManagedObjectContext
  ) {
    guard
      let entity = SharedFlixDatabase.EntityDescription.participant(moc)
    else {
      return nil
    }

    self.init(entity: entity, insertInto: moc)

    self.id        = id
    self.isOwner   = isOwner
    self.paidUntil = paidUntil

    self.person = person
    self.bill   = bill
  }


}

