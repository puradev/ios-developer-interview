//
//  ViewController.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var dataSource = TableViewDataSource(state: .empty)
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var suggestionsView: UITextView!
    
    @IBAction func didTapButton() {
        guard let text = textField.text else {
            return
        }
        
        API.shared.fetchWord(query: text) { response in
            switch response {
            case .success(let data):
                guard let wr = WordResponse.parseData(data) else {
                    return
                }
                // check if suggestions exist, if so this means word wasn't found, empty the table view and show suggestions
                if let sugs = wr.suggestions {
                    self.dataSource.updateState(.empty) {
                        self.tableView.reloadData()
                        self.showSuggestions(query: text, suggestions: sugs)
                    }
                } else {
                    // show the word info
                    self.dataSource.updateState(.word(wr.word)) {
                        self.suggestionsView.isHidden = true
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }
                }
                
            case .failure(let error):
                self.dataSource.updateState(.empty) {
                    self.tableView.reloadData()
                    self.showError()
                }
                print("NETWORK ERROR: ", error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func showSuggestions(query: String, suggestions: [String]) {
        let notFoundSuggestions = "I couldn't find \(query), but here's some suggested words you can explore:\n\n\(suggestions.joined(separator: ", "))"
        
        self.suggestionsView.text = notFoundSuggestions
        self.tableView.isHidden = true
        self.suggestionsView.isHidden = false
        
    }
    
    private func showError() {
        let errorMsg = "There was some sort of error. Pleae check that your internet connection is online and try your search again"
        
        self.suggestionsView.text = errorMsg
        self.tableView.isHidden = true
        self.suggestionsView.isHidden = false
        
    }
}

// use header to display key info about the version of the word (wasn't able to get to implementing multip parts of speech per section in time alloted)
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard case let TableViewDataSource.State.word(word) = dataSource.state  else {
            return UIView()
        }
        
        let wr = WordResult(withWord: word)
        
        // use Swift UI for the header view, when converting to new systems it's helpful to start
        // with the smaller companents and work your way back up
        let vc = UIHostingController(rootView: WordHeaderView(wordResult: wr))
        return vc.view!
    }
}
