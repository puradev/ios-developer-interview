//
//  DefinitionViewController.swift
//  SampleApp
//
//  Created by Nic on 8/8/24.
//

import UIKit

class DefinitionViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var definitionTextView: UITextView!
    
    var word: String?
    var definition: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = word
        definitionTextView.text = definition
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
