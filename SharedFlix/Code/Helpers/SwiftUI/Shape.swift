//
//  Shape.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 15/12/2023.
//

import Foundation
import SwiftUI

struct RoundedTopRectangle: Shape {
  var cornerRadius: CGFloat

  func path(in rect: CGRect) -> Path {
    var path = Path()

    path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
    path.addArc(
      center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
      radius: cornerRadius,
      startAngle: Angle(radians: .pi),
      endAngle: Angle(radians: 1.5 * .pi),
      clockwise: false
    )
    path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
    path.addArc(
      center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
      radius: cornerRadius,
      startAngle: Angle(radians: 1.5 * .pi),
      endAngle: Angle(radians: 2 * .pi),
      clockwise: false
    )
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

    return path
  }
}

struct RoundedBotRectangle: Shape {
  var cornerRadius: CGFloat

  func path(in rect: CGRect) -> Path {
    var path = Path()

    // for some reason clockwise is backwards?
    // also, pi / 2 is top and 1.5pi is bottom?
    // maybe i'm making a double negative?
    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius))
    path.addArc(
      center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
      radius: cornerRadius,
      startAngle: Angle(radians: .pi),
      endAngle: Angle(radians: 0.5 * .pi),
      clockwise: true
    )
    path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
    path.addArc(
      center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
      radius: cornerRadius,
      startAngle: Angle(radians: 0.5 * .pi),
      endAngle: Angle(radians: 0),
      clockwise: true
    )
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

    return path
  }
}
