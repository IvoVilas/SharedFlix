//
//  HomePageViewModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation
import SwiftUI
import CoreData

final class HomePageViewModel: ObservableObject {

  private let systemDateTime: SystemDateTimeType
  private let moc: NSManagedObjectContext

  @Published var bills: [BillViewModel]

  init(
    systemDateTime: SystemDateTimeType,
    moc: NSManagedObjectContext
  ) {
    self.systemDateTime = systemDateTime
    self.moc            = moc

    self.bills = []

    updateData()
  }

  func updateData() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bill")

    do {
      let bills = try moc.fetch(fetchRequest) as! [BillMO]

      self.bills = bills.compactMap { [weak self] bill in
        guard let self else { return nil }

        return BillViewModel(
          systemDateTime: self.systemDateTime,
          bill: BillModel.from(bill)
        )
      }
    } catch {
      print("Error fetching bill data from database")
    }
  }

}
