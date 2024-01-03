//
//  FloatingButtonView.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import SwiftUI

struct FloatingButtonView: View {

  @Binding var isExpanded: Bool

  var body: some View {
    VStack(spacing: 0) {
      Spacer()

      ZStack {
        if isExpanded {
          Button(action: {}) {
            Image(systemName: "trash")
              .resizable()
              .padding(all: 8)
              .frame(width: 40, height: 40)
              .background(Theme.ColorPallete.Blue.v500)
              .foregroundColor(Theme.ColorPallete.White.v100)
          }
          .clipShape(Circle())
          .offset(
            x: isExpanded ? 50 * cos(-180 * Double.pi / 180) : 0,
            y: isExpanded ? 50 * sin(-180 * Double.pi / 180) : 0
          )

          Button(action: {}) {
            Image(systemName: "plus")
              .resizable()
              .padding(all: 8)
              .frame(width: 40, height: 40)
              .background(Theme.ColorPallete.Blue.v500)
              .foregroundColor(Theme.ColorPallete.White.v100)
          }
          .clipShape(Circle())
          .offset(
            x: isExpanded ? 25 * cos(-90 * Double.pi / 180) : 0,
            y: isExpanded ? 25 * sin(-90 * Double.pi / 180) : 0
          )

          Button(action: {}) {
            Image(systemName: "pencil")
              .resizable()
              .padding(all: 8)
              .frame(width: 40, height: 40)
              .background(Theme.ColorPallete.Blue.v500)
              .foregroundColor(Theme.ColorPallete.White.v100)
          }
          .clipShape(Circle())
          .offset(
            x: isExpanded ? 50 * cos(0 * Double.pi / 180) : 0,
            y: isExpanded ? 50 * sin(0 * Double.pi / 180) : 0
          )
        }
      }
      .scaleEffect(isExpanded ? 1 : 0)
      .opacity(isExpanded ? 1 : 0)
      .animation(
        .spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0),
        value: isExpanded
      )

      Button {
        withAnimation { isExpanded.toggle() }
      } label: {
        Image(systemName: "line.3.horizontal")
          .resizable()
          .padding(all: 16)
          .frame(width: 60, height: 60)
          .background(Theme.ColorPallete.Blue.v500)
          .foregroundColor(Theme.ColorPallete.White.v100)
      }
      .clipShape(Circle())
    }
  }

}

#Preview {
  return FloatingButtonView(isExpanded: .constant(true))
}
