//
//  ViewController.swift
//  Etymo
//
//  Created by natehancock on 6/28/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    var dataSource = TableViewDataSource(state: .empty)

    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!

    @IBAction func didTapButton() {
        guard let text = textField.text else {
            return
        }

        API.shared.fetchWord(query: text) { response in
            switch response {
            case .success(let data):
                guard let r = WordResponse.parseData(data) else {
                    return
                }

                self.dataSource.updateState(.word(r.word)) {
                    self.tableView.reloadData()
                }

            case .failure(let error):
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

extension ViewController: UITableViewDelegate {}

struct ViewControllerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController

    func makeUIViewController(context: Context) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = storyboard.instantiateInitialViewController() as! ViewController

        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
