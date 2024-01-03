//
//  Theme+Color.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation
import SwiftUI
import UIKit

public protocol ThemeColor {

  func getAllVersions() -> [(String, Color)]

}

extension Theme {

  public struct ColorPallete {

    fileprivate init() { }

    public static func getAllColors() -> [(String, ThemeColor)] {
      return [
        ("Green", Green()),
        ("Coral", Coral()),
        ("Gray", Gray()),
        ("Blue", Blue()),
        ("Violet", Violet()),
        ("Fuchsia", Fuchsia()),
        ("Yellow", Yellow()),
        ("Petrol", Petrol()),
        ("Red", Red())
      ]
    }

    public struct White {

      fileprivate init() { }

      public static let color = Color.white
      public static let v100 =  Color(hex: 0xFFFFFF)

    }

    public struct Green: ThemeColor {

      fileprivate init() { }

      public static let v900 = Color(hex: 0x0B463A)
      public static let v800 = Color(hex: 0x0F5C4C)
      public static let v700 = Color(hex: 0x157A66)
      public static let v600 = Color(hex: 0x1D967D)
      public static let v500 = Color(hex: 0x1AB394)
      public static let v400 = Color(hex: 0x60D2BB)
      public static let v300 = Color(hex: 0xA8E1D6)
      public static let v200 = Color(hex: 0xD5F6EF)
      public static let v100 = Color(hex: 0xF3FCFA)

      public func getAllVersions() -> [(String, Color)] {
        return [
          ("100", Green.v100),
          ("200", Green.v200),
          ("300", Green.v300),
          ("400", Green.v400),
          ("500", Green.v500),
          ("600", Green.v600),
          ("700", Green.v700),
          ("800", Green.v800),
          ("900", Green.v900)
        ]
      }

    }

    public struct Coral: ThemeColor {

      fileprivate init() { }

      public static let v900 = Color(hex: 0x914F2B)
      public static let v800 = Color(hex: 0xA95C32)
      public static let v700 = Color(hex: 0xCE7240)
      public static let v600 = Color(hex: 0xE2895A)
      public static let v500 = Color(hex: 0xEA9F77)
      public static let v400 = Color(hex: 0xF3C0A5)
      public static let v300 = Color(hex: 0xF7DACA)
      public static let v200 = Color(hex: 0xFAEDE5)
      public static let v100 = Color(hex: 0xFDF9F6)

      public func getAllVersions() -> [(String, Color)] {
        return [
          ("100", Coral.v100),
          ("200", Coral.v200),
          ("300", Coral.v300),
          ("400", Coral.v400),
          ("500", Coral.v500),
          ("600", Coral.v600),
          ("700", Coral.v700),
          ("800", Coral.v800),
          ("900", Coral.v900)
        ]
      }

    }

    public struct Gray: ThemeColor {

      fileprivate init() { }

      public static let v900 = Color(hex: 0x343A46)
      public static let v800 = Color(hex: 0x474F62)
      public static let v700 = Color(hex: 0x5E6982)
      public static let v600 = Color(hex: 0x77829C)
      public static let v500 = Color(hex: 0x97A0B5)
      public static let v400 = Color(hex: 0xB7BECC)
      public static let v300 = Color(hex: 0xD5D9E2)
      public static let v200 = Color(hex: 0xEAECF0)
      public static let v100 = Color(hex: 0xF9FAFB)

      public func getAllVersions() -> [(String, Color)] {
        return [
          ("100", Gray.v100),
          ("200", Gray.v200),
          ("300", Gray.v300),
          ("400", Gray.v400),
          ("500", Gray.v500),
          ("600", Gray.v600),
          ("700", Gray.v700),
          ("800", Gray.v800),
          ("900", Gray.v900)
        ]
      }

    }

    public struct Blue: ThemeColor {

      fileprivate init() { }

      public static let v900 = Color(hex: 0x234670)
      public static let v800 = Color(hex: 0x2E619E)
      public static let v700 = Color(hex: 0x4381CB)
      public static let v600 = Color(hex: 0x6CA3E5)
      public static let v500 = Color(hex: 0x83BCFF)
      public static let v400 = Color(hex: 0xB3D6FF)
      public static let v300 = Color(hex: 0xD6E9FF)
      public static let v200 = Color(hex: 0xEBF4FF)
      public static let v100 = Color(hex: 0xF5F9FF)

      public func getAllVersions() -> [(String, Color)] {
        return [
          ("100", Blue.v100),
          ("200", Blue.v200),
          ("300", Blue.v300),
          ("400", Blue.v400),
          ("500", Blue.v500),
          ("600", Blue.v600),
          ("700", Blue.v700),
          ("800", Blue.v800),
          ("900", Blue.v900)
        ]
      }

    }

    public struct Yellow: ThemeColor {

      fileprivate init() { }

      public static let v900 = Color(hex: 0x95710E)
      public static let v800 = Color(hex: 0xB28710)
      public static let v700 = Color(hex: 0xD3A31D)
      public static let v600 = Color(hex: 0xE6B52D)
      public static let v500 = Color(hex: 0xF3CA58)
      public static let v400 = Color(hex: 0xF8DF9B)
      public static let v300 = Color(hex: 0xFBF0D0)
      public static let v200 = Color(hex: 0xFDF7E8)
      public static let v100 = Color(hex: 0xFEFCF6)

      public func getAllVersions() -> [(String, Color)] {
        return [
          ("100", Yellow.v100),
          ("200", Yellow.v200),
          ("300", Yellow.v300),
          ("400", Yellow.v400),
          ("500", Yellow.v500),
          ("600", Yellow.v600),
          ("700", Yellow.v700),
          ("800", Yellow.v800),
          ("900", Yellow.v900)
        ]
      }

    }

    public struct Violet: ThemeColor {

      fileprivate init() { }

      public static let v900 = Color(hex: 0x474D7B)
      public static let v800 = Color(hex: 0x545B92)
      public static let v700 = Color(hex: 0x6E77BF)
      public static let v600 = Color(hex: 0x8992D1)
      public static let v500 = Color(hex: 0xA7ADDD)
      public static let v400 = Color(hex: 0xC8CCEA)
      public static let v300 = Color(hex: 0xE2E4F4)
      public static let v200 = Color(hex: 0xF0F1F9)
      public static let v100 = Color(hex: 0xFBFCFE)

      public func getAllVersions() -> [(String, Color)] {
        return [
          ("100", Violet.v100),
          ("200", Violet.v200),
          ("300", Violet.v300),
          ("400", Violet.v400),
          ("500", Violet.v500),
          ("600", Violet.v600),
          ("700", Violet.v700),
          ("800", Violet.v800),
          ("900", Violet.v900)
        ]
      }

    }

    public struct Fuchsia: ThemeColor {

      fileprivate init() { }

      public static let v900 = Color(hex: 0x6F4875)
      public static let v800 = Color(hex: 0x84558B)
      public static let v700 = Color(hex: 0xA977B1)
      public static let v600 = Color(hex: 0xBE97C4)
      public static let v500 = Color(hex: 0xD6B8DB)
      public static let v400 = Color(hex: 0xE7D3E8)
      public static let v300 = Color(hex: 0xF2E8F3)
      public static let v200 = Color(hex: 0xF9F5FA)
      public static let v100 = Color(hex: 0xFDFCFD)

      public func getAllVersions() -> [(String, Color)] {
        return [
          ("100", Fuchsia.v100),
          ("200", Fuchsia.v200),
          ("300", Fuchsia.v300),
          ("400", Fuchsia.v400),
          ("500", Fuchsia.v500),
          ("600", Fuchsia.v600),
          ("700", Fuchsia.v700),
          ("800", Fuchsia.v800),
          ("900", Fuchsia.v900)
        ]
      }

    }

    public struct Petrol: ThemeColor {

      fileprivate init() { }

      public static let v900 = Color(hex: 0x002227)
      public static let v800 = Color(hex: 0x00454D)
      public static let v700 = Color(hex: 0x006774)
      public static let v600 = Color(hex: 0x008A9A)
      public static let v500 = Color(hex: 0x00ACC1)
      public static let v400 = Color(hex: 0x33BDCD)
      public static let v300 = Color(hex: 0x66CDDA)
      public static let v200 = Color(hex: 0x99DEE6)
      public static let v100 = Color(hex: 0xCCEEF3)

      public func getAllVersions() -> [(String, Color)] {
        return [
          ("100", Petrol.v100),
          ("200", Petrol.v200),
          ("300", Petrol.v300),
          ("400", Petrol.v400),
          ("500", Petrol.v500),
          ("600", Petrol.v600),
          ("700", Petrol.v700),
          ("800", Petrol.v800),
          ("900", Petrol.v900)
        ]
      }

    }

    public struct Red: ThemeColor {

      fileprivate init() { }

      public static let v900 = Color(hex: 0xC62828)
      public static let v800 = Color(hex: 0xD32F2F)
      public static let v700 = Color(hex: 0xE53935)
      public static let v600 = Color(hex: 0xF44336)
      public static let v500 = Color(hex: 0xEF5350)
      public static let v400 = Color(hex: 0xE57373)
      public static let v300 = Color(hex: 0xEF9A9A)
      public static let v200 = Color(hex: 0xFFCDD2)
      public static let v100 = Color(hex: 0xFFEBEE)

      public func getAllVersions() -> [(String, Color)] {
        return [
          ("100", Red.v100),
          ("200", Red.v200),
          ("300", Red.v300),
          ("400", Red.v400),
          ("500", Red.v500),
          ("600", Red.v600),
          ("700", Red.v700),
          ("800", Red.v800),
          ("900", Red.v900)
        ]
      }

    }

  }

}

extension Color {

  init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")

    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0)
  }

  init(hex: Int) {
    self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff)
  }

}
