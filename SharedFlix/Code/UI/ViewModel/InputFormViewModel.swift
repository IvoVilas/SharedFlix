//
//  InputFormViewModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 18/12/2023.
//

import Foundation
import SwiftUI

protocol InputListItem: Identifiable {

  var name: String { get }

}

final class InputFormViewModel: ObservableObject {

  let title: String
  let placeholder: String
  let keyboardType: UIKeyboardType

  @Published var input: String

  init(
    title: String,
    placeholder: String,
    initialValue: String = "",
    keyboardType: UIKeyboardType = .default
  ) {
    self.title        = title
    self.placeholder  = placeholder
    self.input        = initialValue
    self.keyboardType = keyboardType
  }

}

final class InputListFormViewModel<Item: InputListItem>: ObservableObject {

  let title: String
  let actionTitle: String

  @Published var items: [Item]

  var action: (() -> Void)?

  init(
    title: String,
    addTitle: String,
    items: [Item] = []
  ) {
    self.title       = title
    self.actionTitle = addTitle
    self.items       = items
  }

  func setItems(_ items: [Item]) {
    self.items = items
  }

}

final class InputListsFormViewModel<Item: InputListItem>: ObservableObject {

  enum SectionType: Identifiable {
    case normal(InputListsFormViewModel.Section)
    case limited(InputListsFormViewModel.Section, limit: Int)

    var section: Section {
      switch self {
      case .normal(let section):
        return section

      case .limited(let section, _):
        return section
      }
    }

    var id: Int {
      return section.id
    }
  }

  struct Section: Identifiable {
    let id: Int
    let title: String
    let actionTitle: String
    let items: [Item]

    var action: (() -> Void)?
  }

  let title: String
  
  @Published var sections: [SectionType]
  @Published var forceUpdate: UUID = UUID()

  init(
    title: String,
    sections: [SectionType] = []
  ) {
    self.title    = title
    self.sections = sections
  }

  func setSections(_ sections: [SectionType]) {
    self.sections = sections
  }

  func setItems(
    _ items: [Item],
    forSection sectionId: Int
  ) {
    guard let index = sections.firstIndex(where: { $0.section.id == sectionId }) else {
      return
    }

    let section = sections[index].section

    let newSection = Section(
      id: section.id,
      title: section.title,
      actionTitle: section.actionTitle,
      items: items,
      action: section.action
    )

    switch sections[index] {
    case .normal:
      sections[index] = .normal(newSection)

    case .limited(_, let limit):
      sections[index] = .limited(newSection, limit: limit)
    }

    forceUpdate = UUID()
  }

  func getItems(
    fromSection sectionId: Int
  ) -> [Item] {
    guard let section = sections.first(where: { $0.id == sectionId }) else {
      return []
    }

    return section.section.items
  }

}
