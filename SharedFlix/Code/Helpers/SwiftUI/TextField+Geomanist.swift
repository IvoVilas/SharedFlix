//
//  TextField+Geomanist.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import SwiftUI

extension TextField {

  func applyGeomanistTextStyle(
    _ fontName: GeomanistFont.Name,
    _ fontMetrics: FontMetrics,
    _ textColor: Color
  ) -> some View {
    return self
      .font(GeomanistFont.font(fontName, size: fontMetrics.size))
      .foregroundColor(textColor)
  }

  func applyMediumTextStyle(
    _ fontMetrics: FontMetrics,
    _ textColor: Color
  ) -> some View {
    return applyGeomanistTextStyle(
      .medium,
      fontMetrics,
      textColor
    )
  }

  func applyBookTextStyle(
    _ fontMetrics: FontMetrics,
    _ textColor: Color
  ) -> some View {
    return applyGeomanistTextStyle(
      .book,
      fontMetrics,
      textColor
    )
  }

}
