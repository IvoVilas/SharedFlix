//
//  View+Frame.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation
import SwiftUI

extension View {

  @inlinable public func growVertically(
    alignment: Alignment = .center
  ) -> some View {
    return self.frame(maxHeight: .infinity, alignment: alignment)
  }

  @inlinable public func growHorizontally(
    alignment: Alignment = .center
  ) -> some View {
    return self.frame(maxWidth: .infinity, alignment: alignment)
  }

}
