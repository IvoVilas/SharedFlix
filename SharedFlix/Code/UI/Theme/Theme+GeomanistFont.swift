//
//  Theme+Fonts.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation
import SwiftUI

public struct GeomanistFont {

  public enum Name: String {
    case book = "Geomanist-Book"
    case medium = "Geomanist-Medium"
    case bookItalic = "Geomanist-BookItalic"
    case mediumItalic = "Geomanist-MediumItalic"
  }

  private static let shared = GeomanistFont()

  private init() {
    registerFonts()
  }

  private func registerFonts() {
    [
      GeomanistFont.Name.book.rawValue,
      GeomanistFont.Name.medium.rawValue,
      GeomanistFont.Name.bookItalic.rawValue,
      GeomanistFont.Name.mediumItalic.rawValue
    ].forEach { fontName in
      FontLoader.registerFont(fontName, withExtension: "otf")
    }
  }

  public static func font(_ name: GeomanistFont.Name, size: CGFloat) -> Font {
    return Font(
      shared.getFont(name, size: size)
    )
  }

  private func getFont(_ name: GeomanistFont.Name, size: CGFloat) -> UIFont {
#if DEV_BUILD
    guard let font = UIFont(name: name.rawValue, size: size) else {
      fatalError("Unable to find font \(name.rawValue)")
    }

    return font
#else
    return UIFont(name: name.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
#endif
  }

}


public enum FontMetrics {

  case xs2
  case xs
  case sm
  case m
  case l
  case xl
  case xl2
  case xl3
  case xl4
  case xl5
  case xl6

  public var size: CGFloat {
    switch self {
    case .xs2:
      return 11

    case .xs:
      return 12

    case .sm:
      return 13

    case .m:
      return 14

    case .l:
      return 16

    case .xl:
      return 18

    case .xl2:
      return 20

    case .xl3:
      return 24

    case .xl4:
      return 32

    case .xl5:
      return 40

    case .xl6:
      return 60
    }
  }

}
