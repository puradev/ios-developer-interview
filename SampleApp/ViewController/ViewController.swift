//
//  ViewController.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import UIKit

class ViewController: UIViewController {
    //var viewModel = ViewModel()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func didTapButton() {
//        guard let text = textField.text else {
//            return
//        }
//
//        viewModel.fetchDefinition(text) { [weak self] in
//            self?.tableView.reloadData()
//        } failure: { [weak self] errorMessage in
//            self?.tableView.reloadData()
//
//            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default))
//            self?.present(alert, animated: true)
//        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.dataSource = viewModel.dataSource
        //tableView.rowHeight = UITableView.automaticDimension
    }
}
