//
//  DialogViewController.swift
//  SampleApp
//
//  Created by Keith Michelson on 8/14/24.
//

import UIKit

class DialogViewController: ViewController {
    
    var titleMessage: String?
    var bodyDetails: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dialogBackground: UIView!
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        titleLabel.text = titleMessage
        bodyLabel.text = bodyDetails
        dialogBackground.layer.cornerRadius = 15
        dialogBackground.layer.masksToBounds = true
    }
    
    @IBAction func OKayButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
