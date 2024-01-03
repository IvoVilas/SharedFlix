//
//  SharedFlixApp.swift
//  SharedFlix
//
//  Created by Ivo Vilas on 13/12/2023.
//

import SwiftUI

@main
struct SharedFlixApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
