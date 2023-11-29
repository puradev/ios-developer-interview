//
//  ViewController.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import UIKit

class ViewController: UIViewController {

    var dataSource = TableViewDataSource(state: .empty)
    let api: WordFetchProvider = API.shared

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func didTapButton() {
        guard let text = textField.text else {
            return
        }

        Task {
            do {
                guard let wordResponse = try await api.fetch(word: text).first else {
                    self.dataSource.updateState(.empty) {
                        self.tableView.reloadData()
                    }

                    return
                }

                self.dataSource.updateState(.word(wordResponse.word)) {
                    self.tableView.reloadData()
                }
            } catch {
                self.dataSource.updateState(.empty) {
                    self.tableView.reloadData()
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


}

extension ViewController: UITableViewDelegate {
    
}
