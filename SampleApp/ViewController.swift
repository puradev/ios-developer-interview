//
//  ViewController.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import UIKit
import SwiftUI


class ViewController: UIViewController {
    
    let childVC = UIHostingController(rootView: SearchedWordScreen())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(childVC)
        view.addSubview(childVC.view)
        childVC.view.frame = view.frame
    }

}

