//
//  SharedFlixApp.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 13/12/2023.
//

import SwiftUI
import CoreData

@main
struct SharedFlixApp: App {

  let systemDateTime: SystemDateTimeType
  let container = NSPersistentContainer(name: "SharedFlix")

  init() {
    self.systemDateTime = SystemDateTime()
  }

  var body: some Scene {
    WindowGroup {
      Text("Hello world")
    }
  }
}
