//
//  Theme+Color.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import Foundation
import SwiftUI
import UIKit

extension Theme {

  public struct ColorPallete {

    private init() { }

    public struct White {

      private init() { }

      public static let color = Color.white
      public static let v100 =  Color(hex: 0xFFFFFF)

    }

    public struct Green {

      private init() { }

      public static let v900 = Color(hex: 0x0B463A)
      public static let v800 = Color(hex: 0x0F5C4C)
      public static let v700 = Color(hex: 0x157A66)
      public static let v600 = Color(hex: 0x1D967D)
      public static let v500 = Color(hex: 0x1AB394)
      public static let v400 = Color(hex: 0x60D2BB)
      public static let v300 = Color(hex: 0xA8E1D6)
      public static let v200 = Color(hex: 0xD5F6EF)
      public static let v100 = Color(hex: 0xF3FCFA)

    }

    public struct Coral {

      private init() { }

      public static let v900 = Color(hex: 0x914F2B)
      public static let v800 = Color(hex: 0xA95C32)
      public static let v700 = Color(hex: 0xCE7240)
      public static let v600 = Color(hex: 0xE2895A)
      public static let v500 = Color(hex: 0xEA9F77)
      public static let v400 = Color(hex: 0xF3C0A5)
      public static let v300 = Color(hex: 0xF7DACA)
      public static let v200 = Color(hex: 0xFAEDE5)
      public static let v100 = Color(hex: 0xFDF9F6)

    }

    public struct Gray {

      private init() { }

      public static let v900 = Color(hex: 0x343A46)
      public static let v800 = Color(hex: 0x474F62)
      public static let v700 = Color(hex: 0x5E6982)
      public static let v600 = Color(hex: 0x77829C)
      public static let v500 = Color(hex: 0x97A0B5)
      public static let v400 = Color(hex: 0xB7BECC)
      public static let v300 = Color(hex: 0xD5D9E2)
      public static let v200 = Color(hex: 0xEAECF0)
      public static let v100 = Color(hex: 0xF9FAFB)

    }

    public struct Blue {

      private init() { }

      public static let v900 = Color(hex: 0x234670)
      public static let v800 = Color(hex: 0x2E619E)
      public static let v700 = Color(hex: 0x4381CB)
      public static let v600 = Color(hex: 0x6CA3E5)
      public static let v500 = Color(hex: 0x83BCFF)
      public static let v400 = Color(hex: 0xB3D6FF)
      public static let v300 = Color(hex: 0xD6E9FF)
      public static let v200 = Color(hex: 0xEBF4FF)
      public static let v100 = Color(hex: 0xF5F9FF)

    }

    public struct Yellow {

      private init() { }

      public static let v900 = Color(hex: 0x95710E)
      public static let v800 = Color(hex: 0xB28710)
      public static let v700 = Color(hex: 0xD3A31D)
      public static let v600 = Color(hex: 0xE6B52D)
      public static let v500 = Color(hex: 0xF3CA58)
      public static let v400 = Color(hex: 0xF8DF9B)
      public static let v300 = Color(hex: 0xFBF0D0)
      public static let v200 = Color(hex: 0xFDF7E8)
      public static let v100 = Color(hex: 0xFEFCF6)

    }

    public struct Violet {

      private init() { }

      public static let v900 = Color(hex: 0x474D7B)
      public static let v800 = Color(hex: 0x545B92)
      public static let v700 = Color(hex: 0x6E77BF)
      public static let v600 = Color(hex: 0x8992D1)
      public static let v500 = Color(hex: 0xA7ADDD)
      public static let v400 = Color(hex: 0xC8CCEA)
      public static let v300 = Color(hex: 0xE2E4F4)
      public static let v200 = Color(hex: 0xF0F1F9)
      public static let v100 = Color(hex: 0xFBFCFE)

    }

    public struct Fuchsia {

      private init() { }

      public static let v900 = Color(hex: 0x6F4875)
      public static let v800 = Color(hex: 0x84558B)
      public static let v700 = Color(hex: 0xA977B1)
      public static let v600 = Color(hex: 0xBE97C4)
      public static let v500 = Color(hex: 0xD6B8DB)
      public static let v400 = Color(hex: 0xE7D3E8)
      public static let v300 = Color(hex: 0xF2E8F3)
      public static let v200 = Color(hex: 0xF9F5FA)
      public static let v100 = Color(hex: 0xFDFCFD)

    }

    public struct Petrol {

      private init() { }

      public static let v900 = Color(hex: 0x002227)
      public static let v800 = Color(hex: 0x00454D)
      public static let v700 = Color(hex: 0x006774)
      public static let v600 = Color(hex: 0x008A9A)
      public static let v500 = Color(hex: 0x00ACC1)
      public static let v400 = Color(hex: 0x33BDCD)
      public static let v300 = Color(hex: 0x66CDDA)
      public static let v200 = Color(hex: 0x99DEE6)
      public static let v100 = Color(hex: 0xCCEEF3)

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
