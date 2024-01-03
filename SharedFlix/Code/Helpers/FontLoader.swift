//
//  FontLoader.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 14/12/2023.
//

import UIKit

internal struct FontLoader {

  // Code from internet
  internal static func registerFont(_ name: String, withExtension ext: String) {
    let bundle  = Bundle.main
    let fontUrl = bundle.url(forResource: name, withExtension: ext)

    guard
      let fontUrl = fontUrl,
      let data = try? Data(contentsOf: fontUrl) as CFData,
      let provider = CGDataProvider(data: data),
      let font = CGFont(provider)
    else {
      return
    }

    var error: Unmanaged<CFError>?

    if CTFontManagerRegisterGraphicsFont(font, &error) {
      return
    }

#if DEV_BUILD
    if let error = error {
      let errorDescription: CFString = CFErrorCopyDescription(error.takeUnretainedValue())

      fatalError("\(errorDescription)")
    } else {
      fatalError("Unable to register font \(name)")
    }
#endif
  }

}
