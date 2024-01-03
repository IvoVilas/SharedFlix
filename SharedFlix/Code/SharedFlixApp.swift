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
  let persistenceController: PersistenceController

  init() {
    self.systemDateTime        = SystemDateTime()
    self.persistenceController = PersistenceController.shared
  }

  var body: some Scene {
    WindowGroup {
      HomePageView(
        viewModel: HomePageViewModel(
          systemDateTime: systemDateTime,
          moc: persistenceController.container.viewContext
        )
      )
    }
  }
}
