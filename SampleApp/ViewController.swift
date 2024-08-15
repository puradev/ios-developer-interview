//
//  ViewController.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import UIKit

class ViewController: UIViewController {

    var dataSource = TableViewDataSource(state: .empty)
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var speechTypeLabel: UILabel!
    @IBOutlet weak var validationMessage: UILabel!
    
    @IBAction func didTapButton() {
        
        guard let text = textField.text, !text.isEmpty else {
            resetValidation()
            return
        }
        
        if text.lowercased() == "konami code" {
            wordLabel.text = "REST 30"
            self.wordLabel.isHidden = false
            self.speechTypeLabel.text = "☝ ☝ 👇 👇 👈 👉 👈 👉 B A ▶️"
            self.speechTypeLabel.isHidden = false
            self.dataSource.updateState(.empty) {
                self.tableView.reloadData()
            }
            resetValidation()
            return
        }
        
        API.shared.fetchWord(query: text) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    guard let r = WordResponse.parseData(data) else {
                        self.showDialog(titleMessage: "\(self.textField.text ?? "Your word") was not found", bodyDetails: "The word you've entered isn't in the dictionary. Check the spelling and try again.")
                        self.hideLabels()
                        return
                    }
                    
                    self.dataSource.updateState(.word(r.word)) {
                        self.tableView.reloadData()
                        self.wordLabel.isHidden = false
                        self.wordLabel.text = self.textField.text
                        self.speechTypeLabel.isHidden = false
                        self.speechTypeLabel.text = r.word.speechType
                        self.resetValidation()
                    }
                    
                case .failure(let error):
                    self.dataSource.updateState(.empty) {
                        self.tableView.reloadData()
                    }
                    
                    print("NETWORK ERROR: ", error.localizedDescription)
                    
                    self.handleError(error)
                    self.hideLabels()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = dataSource
        tableView.delegate = self

        tableView.rowHeight = UITableView.automaticDimension
        
        hideLabels()
    }
    
    func hideLabels() {
        wordLabel.isHidden = true
        speechTypeLabel.isHidden = true
        resetValidation()
    }
    
    func resetValidation() {
        validationMessage.text = ""
        validationMessage.isHidden = true
    }
    
    private func handleError(_ error: APIError) {
        var titleMessage = ""
        var errorMessage = ""
        var validationError = false

        switch error {
        case .emptyQuery:
            titleMessage = ""
            errorMessage = "The input field is empty."
            validationError = true
        case .tooShort:
            titleMessage = ""
            errorMessage = "The word is too short."
            validationError = true
        case .badURL:
            titleMessage = "Not Found"
            errorMessage = "The Word is not found or spelled incorrectly."
            validationError = false
        case .noData:
            titleMessage = "Server Error"
            errorMessage = "No data received from the server."
            validationError = false
        case .custom(let message):
            titleMessage = "Custom Error"
            errorMessage = message
            validationError = false
        }

        if !validationError {
            self.showDialog(titleMessage: titleMessage, bodyDetails: errorMessage)
        } else {
            DispatchQueue.main.async {
                self.validationMessage.isHidden = false
                self.validationMessage.text = errorMessage
            }
        }
    }
    
    func showDialog(titleMessage: String, bodyDetails: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DialogViewController") as! DialogViewController
        controller.modalPresentationStyle = .overCurrentContext
        controller.providesPresentationContextTransitionStyle = true
        controller.definesPresentationContext = true
        controller.modalTransitionStyle = .crossDissolve
        controller.titleMessage = titleMessage
        controller.bodyDetails = bodyDetails
        self.present(controller, animated: true, completion: nil)
    }


}

extension ViewController: UITableViewDelegate {
    
}
