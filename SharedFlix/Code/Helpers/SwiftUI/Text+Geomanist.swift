//
//  TextHelpers.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import SwiftUI

extension Text {

  func applyGeomanistTextStyle(
    _ fontName: GeomanistFont.Name,
    _ fontMetrics: FontMetrics,
    _ textColor: Color
  ) -> Text {
    return self
      .font(GeomanistFont.font(fontName, size: fontMetrics.size))
      .foregroundColor(textColor)
  }

  func applyMediumTextStyle(
    _ fontMetrics: FontMetrics,
    _ textColor: Color
  ) -> Text {
    return applyGeomanistTextStyle(
      .medium,
      fontMetrics,
      textColor
    )
  }

  func applyBookTextStyle(
    _ fontMetrics: FontMetrics,
    _ textColor: Color
  ) -> Text {
    return applyGeomanistTextStyle(
      .book,
      fontMetrics,
      textColor
    )
  }

}
