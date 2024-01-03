//
//  Theme+Preview.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import SwiftUI

struct ColorPalletePreview: View {

  var body: some View {
    GeometryReader { geo in
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          ForEach(Theme.ColorPallete.getAllColors(), id: \.0) { (name, color) in
            ColorPreview(name: name, color: color)
              .frame(width: (geo.size.width - 40) / 4)
          }
        }
      }
    }
  }

}

struct ColorPreview: View {

  let name: String
  let color: ThemeColor

  var body: some View {
    VStack(spacing: 0) {
      ForEach(color.getAllVersions(), id: \.0) { (name, color) in
        Rectangle()
          .foregroundStyle(color)
          .overlay { Text(name) }
      }

      Spacer().frame(height: 10)

      Text(name)

      Spacer().frame(height: 10)
    }
  }

}



#Preview {
  ColorPalletePreview()
}
