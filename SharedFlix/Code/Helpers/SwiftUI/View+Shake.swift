//
//  View+Shake.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 15/12/2023.
//

import Foundation
import SwiftUI

extension View {

  func shake(
    shouldShake: Bool
  ) -> some View {
    self.modifier(
      ShakeModifier(shouldShake: shouldShake)
    )
  }

}

struct ShakeModifier: ViewModifier {

  let shouldShake: Bool

  func body(content: Content) -> some View {
//    content.modifier(
//      ShakingEffect(shouldShake: shouldShake)
//    )
    content.offset(x: shouldShake ? 5 : 0)
  }

}

struct ShakingEffect: GeometryEffect {

  var shouldShake: Bool
  var progress: CGFloat = 0

  var animatableData: CGFloat {
    get { progress }
    set { progress = newValue }
  }

  func effectValue(size: CGSize) -> ProjectionTransform {
    let angle: CGFloat = shouldShake ? .pi / 32 : 0
    let a              = angle * sin(.pi * progress)

    return ProjectionTransform(CGAffineTransform(rotationAngle: a))
  }
}
