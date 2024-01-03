//
//  PersonModel.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation

struct PersonModel {

  let id: Int64
  let name: String

  static func from(_ entity: PersonMO) -> PersonModel {
    return PersonModel(
      id: entity.id,
      name: entity.name
    )
  }
}
