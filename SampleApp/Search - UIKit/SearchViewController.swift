//
//  SearchViewController.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import UIKit

class SearchViewController: UIViewController {

    // TextField and Search Button
    var textFieldStackView = UIStackView()
    var textField = UITextField()
    var searchButton = UIButton(configuration: .filled())
    
    // TableView
    var dataSource = TableViewDataSource(state: .empty)
    var tableView = UITableView()
    
    // Loading View
    var loadingView = UIView()
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    var loadingViewIsActive: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.loadingView.isHidden = !self.loadingViewIsActive
                if self.loadingViewIsActive {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    // Error View
    var errorView = UIView()
    var errorLabelView = UILabel()
    var error: String? = nil {
        didSet {
            DispatchQueue.main.async {
                self.errorView.isHidden = self.error == nil
                self.errorLabelView.text = self.error
            }
        }
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupTextField()
        setupTableView()
        setupLoadingView()
        setupErrorView()
    }
    
    // MARK: Appearance/View Setup
    func setupAppearance() {
        view.backgroundColor = .white
    }
    
    func setupTableView() {
        // Setup TableView data
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DictionaryTableViewCell.self, forCellReuseIdentifier: "dictionaryCell")
        
        // Add TableView to View
        view.addSubview(tableView)
        view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        textFieldStackView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
    }
    
    func setupLoadingView() {
        // Add Loading View
        tableView.addSubviewWithFillConstraints(subview: loadingView)
        loadingView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        // Style and add Activity Indicator
        loadingView.backgroundColor = .white
        loadingView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor).isActive = true
        loadingView.isHidden = true
    }
    
    func setupErrorView() {
        // Add Error View
        tableView.addSubviewWithFillConstraints(subview: errorView)
        errorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        // Style Error Label
        errorLabelView.translatesAutoresizingMaskIntoConstraints = false
        errorLabelView.lineBreakMode = .byWordWrapping
        errorLabelView.numberOfLines = 10
        
        // Add and Center Error Label
        errorView.backgroundColor = .white
        errorView.addSubview(errorLabelView)
        errorView.centerYAnchor.constraint(equalTo: errorLabelView.centerYAnchor).isActive = true
        errorView.centerXAnchor.constraint(equalTo: errorLabelView.centerXAnchor).isActive = true
        errorLabelView.widthAnchor.constraint(lessThanOrEqualTo: errorView.widthAnchor, constant: -40).isActive = true
        errorView.isHidden = true
    }
    
    func setupTextField() {
        // Style Stackview
        textFieldStackView.axis = .horizontal
        textFieldStackView.addArrangedSubview(textField)
        textFieldStackView.addArrangedSubview(searchButton)
        textFieldStackView.distribution = .fill
        textFieldStackView.alignment = .fill
        textFieldStackView.spacing = 16
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Style Textfield
        textField.borderStyle = .roundedRect
        textField.placeholder = "Search Term"
        
        // Style Search Button
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        // Add to View with Constraints
        view.addSubview(textFieldStackView)
        view.keyboardLayoutGuide.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 24).isActive = true
        view.leadingAnchor.constraint(equalTo: textFieldStackView.leadingAnchor, constant: -20).isActive = true
        view.trailingAnchor.constraint(equalTo: textFieldStackView.trailingAnchor, constant: 20).isActive = true
    }

    // MARK: Button Logic
    @objc func didTapButton() {
        guard let text = textField.text else {
            return
        }
        
        loadingViewIsActive = true
        error = nil
        
        API.shared.fetchWord(query: text) { response in
            switch response {
            case .success(let data):
                guard let r = WordResponse.parseData(data) else {
                    self.error = "Could not parse data"
                    self.loadingViewIsActive = false
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
                self.error = "NETWORK ERROR: \(error.localizedDescription)"
            }
            
            self.loadingViewIsActive = false
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
}
