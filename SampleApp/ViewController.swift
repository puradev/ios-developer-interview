//
//  ViewController.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var requirementLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var overlayLabel: UILabel!
    
    var dataSource = TableViewDataSource(state: .empty)
    let viewModel = WordViewModel()
    private var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Subscribe to ViewModel publisher for any UI state Updates
        viewModel.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.updateUI(with: state)
            }
            .store(in: &subscribers)
    }
    
    private func setupUI() {
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: WordDefinitionTableViewCell.reuseID, bundle: nil), forCellReuseIdentifier: WordDefinitionTableViewCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        
        textField.delegate = self
        textField.placeholder = .hintString
        
        searchButton.isEnabled = false
        requirementLabel.isHidden = true
        requirementLabel.text = .requirementString
        overlayView.isHidden = true
        displayOverlayWith(message: .emptyStateString)
        
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapToDismiss)
        
        // set gradient background
        let colorTop =  UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 58.0/255.0, green: 94.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    @IBAction func didTapButton() {
        hideKeyboard()
        
        guard let text = textField.text else {
            displayOverlayWith(message: .unknownErrorString)
            return
        }
        viewModel.fetchWord(query: text)
    }
    
    func updateUI(with state: WordViewModel.State) {
        switch state {
        case .word(let word):
            self.dataSource.updateState(.word(word)) {
                self.tableView.reloadData()
                self.overlayView.isHidden = true
            }
        case .empty:
            self.dataSource.updateState(.empty) {
                self.tableView.reloadData()
                self.displayOverlayWith(message: .emptyStateString)
            }
        case .invalid:
            self.dataSource.updateState(.empty) {
                self.tableView.reloadData()
                self.displayOverlayWith(message: .invalidStateString)
            }
        case .networkError:
            self.dataSource.updateState(.empty) {
                self.tableView.reloadData()
                self.displayOverlayWith(message: .unknownErrorString)
            }
        }
    }
    
    func displayOverlayWith(message: String) {
        DispatchQueue.main.async {
            self.overlayLabel.text = message
            self.overlayView.isHidden = false
        }
    }
    
    @objc func hideKeyboard() {
        textField.resignFirstResponder()
    }
    
    deinit {
        subscribers.forEach { $0.cancel() }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // ignore white spaces and new lines from user input
        guard string.rangeOfCharacter(from: .whitespacesAndNewlines) == nil else {
            return false
        }
        
        // manage word UI states depending on minimum word length requirement
        if let wordLength = (textField.text as NSString?)?.replacingCharacters(in: range, with: string).count {
            searchButton.isEnabled = wordLength > 2
            requirementLabel.isHidden = (wordLength > 2 || wordLength == 0)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // show empty state whenever search field is empty
        guard let txt = textField.text, txt.isEmpty else { return }
        displayOverlayWith(message: .emptyStateString)
    }
}

fileprivate extension String {
    static let requirementString = " * please enter a 3 letter word or longer"
    static let hintString = "Example: rizz, yeet, etc."
    static let emptyStateString = "Searching for a definition? Please enter a word!"
    static let invalidStateString = "The word entered is invalid. Please check its spelling and search again."
    static let unknownErrorString = "Something went wrong. Please try again."
}
