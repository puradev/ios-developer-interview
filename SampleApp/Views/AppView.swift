//
//  SampleApp_app.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/26/24.
//

import SwiftUI
import SwiftData

@main
struct AppView: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WordEntry.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            let model = try ModelContainer(for: schema, configurations: [modelConfiguration])
            model.mainContext.autosaveEnabled = true
            return model
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()


    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(sharedModelContainer)
        }
    }
}

