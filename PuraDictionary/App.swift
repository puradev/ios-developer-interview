//
//  App.swift
//  PuraDictionary
//
//  Created by Marcus Brown on 1/20/24.
//
import SwiftUI

@main
struct PuraDictionary: App {
    var body: some Scene {
        WindowGroup {
            MainView(model: ViewModel())
        }
    }
}
