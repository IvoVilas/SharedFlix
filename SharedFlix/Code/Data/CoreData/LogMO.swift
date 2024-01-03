//
//  LogMO.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 13/12/2023.
//

import Foundation
import CoreData

class LogMO: NSManagedObject {

  @NSManaged var id: Int64
  @NSManaged var date: Date
  @NSManaged var value: Double

  @NSManaged var bill: BillMO

  convenience init?(
    id: Int64,
    date: Date,
    value: Double,
    bill: BillMO,
    moc: NSManagedObjectContext
  ) {
    guard
      let entity = SharedFlixDatabase.EntityDescription.log(moc)
    else {
      return nil
    }

    self.init(entity: entity, insertInto: moc)

    self.id    = id
    self.date  = date
    self.value = value

    self.bill = bill
  }

}
