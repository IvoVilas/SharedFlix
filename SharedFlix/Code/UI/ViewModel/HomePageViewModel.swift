//
//  HomePageViewModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation
import SwiftUI
import CoreData
import Combine

final class HomePageViewModel: ObservableObject {

  private let systemDateTime: SystemDateTimeType
  private let moc: NSManagedObjectContext

  @Published var bills: [BillViewModel]

  // FloatingButton
  enum State {
    case normal
    case expanded
    case removing
  }

  @Published var showBillScreen: Bool
  @Published var buttonState: HomePageViewModel.State

  var buttonIconName: AnyPublisher<String, Never> {
    return $buttonState
      .map {
        switch $0 {
        case .normal, .expanded:
          return "line.3.horizontal"
        case .removing:
          return "arrow.uturn.left"
        }
      }
      .eraseToAnyPublisher()
  }

  var isExpanded: AnyPublisher<Bool, Never> {
    return $buttonState
      .map { $0 == .expanded }
      .eraseToAnyPublisher()
  }

  init(
    systemDateTime: SystemDateTimeType,
    moc: NSManagedObjectContext
  ) {
    self.systemDateTime = systemDateTime
    self.moc            = moc

    self.bills = []

    self.buttonState    = .normal
    self.showBillScreen = false

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

extension HomePageViewModel {

  func onCenterAction() {
    switch buttonState {
    case .normal:
      buttonState = .expanded

    case .expanded:
      buttonState = .normal

    case .removing:
      onStopRemoveBillAction()

      buttonState = .normal
    }
  }

  func onCreateBillAction() {
    showBillScreen = true

    buttonState = .normal
  }

  func onStartRemoveBillAction() {
    buttonState = .removing

    bills.forEach { $0.isRemoving = true }
  }

  func onStopRemoveBillAction() {
    buttonState = .removing

    bills.forEach { $0.isRemoving = false }
  }

}
