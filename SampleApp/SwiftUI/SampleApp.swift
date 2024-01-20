//
//  SampleApp.swift
//  SampleApp
//
//  Created by Mark Davis on 1/20/24.
//

import SwiftUI

@main
struct SampleApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
