//
//  Views.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 18/12/2023.
//

import Foundation
import SwiftUI

// MARK: - LineView
struct LineView: View {

  let color: Color
  let lineWidth: CGFloat

  var body: some View {
    GeometryReader { geometry in
      Path { path in
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
      }
      .stroke(color, lineWidth: lineWidth)
    }
    .frame(height: lineWidth)
  }

}

#Preview {
  LineView(color: Theme.ColorPallete.Gray.v900, lineWidth: 2)
}
