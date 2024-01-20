//
//  ContentView.swift
//  SampleApp
//
//  Created by Mark Davis on 1/20/24.
//

import SwiftUI

struct ContentView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController

    func makeUIViewController(context: Context) -> ViewController {
        
        // Load Main.storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate ViewController
        guard let viewController = storyboard.instantiateInitialViewController() as? ViewController else {
            fatalError("Couldn't instanciate a ViewController class.")
        }
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}
