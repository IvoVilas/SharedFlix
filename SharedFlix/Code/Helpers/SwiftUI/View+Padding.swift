//
//  View+Padding.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation
import SwiftUI

extension View {

  @inlinable public func padding(all value: CGFloat) -> some View {
    return self.padding(
      EdgeInsets(
        top: value,
        leading: value,
        bottom: value,
        trailing: value
      )
    )
  }

  @inlinable public func padding(horizontal value: CGFloat) -> some View {
    return self.padding(
      EdgeInsets(
        top: 0,
        leading: value,
        bottom: 0,
        trailing: value
      )
    )
  }

}
