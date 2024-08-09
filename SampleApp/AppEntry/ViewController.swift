    //
    //  ViewController.swift
    //  SampleApp
    //
    //  Created by natehancock on 6/28/22.
    //

import UIKit

class ViewController: UIViewController {
    
    var dataSource = TableViewDataSource(state: .empty)
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noResultsImageView: UIImageView!
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    var word: Word? = nil {
        willSet {
            if let newValue {
                self.dataSource.updateState(.word(newValue)) { [weak self] in
                    self?.tableView.reloadData()
                    self?.configureContent(dataFound: true)
                }
            } else {
                self.dataSource.updateState(.empty) { [weak self] in
                    self?.tableView.reloadData()
                    self?.configureContent(dataFound: false)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        textField.delegate = self
        
        overlayView.frame = view.frame
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.5) // semi-transparent black
        overlayView.isHidden = true
        
        activityIndicator.center = overlayView.center
        activityIndicator.hidesWhenStopped = true
        
        overlayView.addSubview(activityIndicator)
        
        view.addSubview(overlayView)
        
        configureContent(dataFound: false)
    }
    
    @IBAction func didTapButton() {
        guard let text = textField.text, !text.isEmpty else { return }
        showActivityIndicator()
        API.shared.fetchWord(query: text) { [weak self] response in
            guard let self else { return }
            switch response {
                case .success(let data):
                    self.word = WordResponse.parseData(data)
                    self.hideActivityIndicator()
                case .failure(let error):
                    self.word = nil
                    print("NETWORK ERROR: ", error.localizedDescription)
                    self.hideActivityIndicator()
            }
        }
    }
    
    private func showActivityIndicator() {
        overlayView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            activityIndicator.stopAnimating()
            overlayView.isHidden = true
        }
    }
    
    private func configureContent(dataFound: Bool) {
        self.tableView.isHidden = !dataFound
        self.noResultsImageView.isHidden = dataFound
    }
}

extension ViewController: UITableViewDelegate {
    
        // In a real project, I would consider options for appropriate dependency injection and avoid retain cycles, like with MVVM. For the sake of simplicity, and since this is just strings, I'm putting them directly on the VC.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Don't navigate if tapping word cell, only definition cells
        guard indexPath.row > 0,
              let definitionVC = UIStoryboard(name: "DefinitionViewController", bundle: nil).instantiateViewController(withIdentifier: "DefinitionVC") as? DefinitionViewController,
              let word = word else {
                // Error handling an alert, which realistically should never happen. Famous last words.
            return
        }
        definitionVC.word = word.text
            // Subtract 1 to accommodate for title cell
        definitionVC.definition = word.definitions[indexPath.row - 1]
        present(definitionVC, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapButton()
        return true
    }
}
