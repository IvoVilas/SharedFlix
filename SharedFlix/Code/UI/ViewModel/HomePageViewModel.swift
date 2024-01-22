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

  private var currentCreateBillViewModel: CreateBillViewModel?

  @Published var bills: [BillViewModel]

  // FloatingButton
  enum State {
    case normal
    case expanded
    case removing
    case creating
  }

  @Published var buttonState: HomePageViewModel.State

  var buttonIconName: AnyPublisher<String, Never> {
    return $buttonState
      .map {
        switch $0 {
        case .normal, .expanded:
          return "line.3.horizontal"
        case .removing, .creating:
          return "xmark"
        }
      }
      .eraseToAnyPublisher()
  }

  var isExpanded: AnyPublisher<Bool, Never> {
    return $buttonState
      .map { $0 == .expanded }
      .eraseToAnyPublisher()
  }

  var isRemoving: AnyPublisher<Bool, Never> {
    return $buttonState
      .map { $0 == .removing }
      .eraseToAnyPublisher()
  }

  var isCreating: AnyPublisher<Bool, Never> {
    return $buttonState
      .map { $0 == .creating }
      .eraseToAnyPublisher()
  }

  init(
    systemDateTime: SystemDateTimeType,
    moc: NSManagedObjectContext
  ) {
    self.systemDateTime = systemDateTime
    self.moc            = moc

    self.bills = []

    self.buttonState = .normal

    updateData()
  }

  func updateData() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bill")

    do {
      let foundBills = try moc.fetch(fetchRequest) as! [BillMO]

      var bills         = [BillViewModel]()
      let existingBills = self.bills.filter { foundBills.map { $0.id }.contains($0.getBillId()) }
      let newBills      = foundBills.filter { [weak self] bill in
          guard let self else { return false }

          return !self.bills.map {$0.getBillId() }.contains(bill.id)
        }

      bills.append(contentsOf: existingBills)

      bills.append(
        contentsOf: newBills.compactMap { [weak self] bill in
          guard let self else { return nil }

          let billModel = BillModel.from(bill)

          return BillViewModel(
            systemDateTime: self.systemDateTime,
            bill: billModel,
            deleteAction: { [weak self] in self?.onDeleteBillAction(billModel.id) }
          )
        }
      )

      bills.sort { $0.getBillCreateAt() < $1.getBillCreateAt() }

      self.bills = bills
    } catch {
      print("Error fetching bill data from database")
    }
  }

  func deleteBill(
    _ id: String
  ) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bill")

    fetchRequest.predicate = NSPredicate(format: "id == %@", id)

    do {
      let result = try moc.fetch(fetchRequest) as? [BillMO]

      if let bill = result?.first {
        moc.delete(bill)

        try moc.save()
      } else {
        print("Couldn't find bill with id: \(id)")
      }

    } catch {
      print("Error removing bill with id: \(id)")
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

    case .creating:
      onCancelBillCreationAction()
    }
  }

  func onCreateBillAction() {
    buttonState = .creating
  }

  func onConfirmBillCreationAction() {
    guard let currentCreateBillViewModel else { return }

    if currentCreateBillViewModel.onUserWantsToCreateBill() {
      buttonState = .normal

      updateData()
    }
  }

  func onCancelBillCreationAction() {
    buttonState = .normal

    currentCreateBillViewModel = nil
  }

  func onStartRemoveBillAction() {
    buttonState = .removing

    bills.forEach { $0.isRemoving = true }
  }

  func onStopRemoveBillAction() {
    buttonState = .normal

    bills.forEach { $0.isRemoving = false }
  }

  func onDeleteBillAction(_ id: String) {
    self.deleteBill(id)

    self.updateData()

    if self.bills.isEmpty { onStopRemoveBillAction() }
  }

}

extension HomePageViewModel {

  func makeCreateBillViewModel() -> CreateBillViewModel {
    let viewModel = CreateBillViewModel(moc: moc)

    self.currentCreateBillViewModel = viewModel

    return viewModel
  }

}
