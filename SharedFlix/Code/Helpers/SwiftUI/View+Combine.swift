//
//  View+Combine.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 15/12/2023.
//

import Foundation
import SwiftUI
import Combine

extension View {

  @inlinable public func assign<Value>(
    _ property: Binding<Value>,
    to publisher: AnyPublisher<Value, Never>
  ) -> some View {
    self.onReceive(publisher) { value in
      property.wrappedValue = value
    }
  }

}
