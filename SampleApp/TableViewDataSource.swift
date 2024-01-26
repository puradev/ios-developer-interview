//
//  TableViewDataSource.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation
import UIKit
import SwiftUI

class TableViewDataSource: NSObject {
    
    enum State {
        case empty
        case word(Word)
        case suggestions([String])
    }

    var state: State
    init(state: State) {
        self.state = state
    }
    
    func updateState(_ state: State, completion: @escaping () -> ()) {
        self.state = state
        DispatchQueue.main.async {
            completion()
        }
    }
}

extension TableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case let State.word(word) = state  else {
            return 0
        }
        return word.definitions.count
    }
    
    // use sections for parts of speech versions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let State.word(word) = state  else {
            return UITableViewCell()
        }
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        
        let wr = WordResult(withWord: word)
        if wr.definitions.count > indexPath.row {
            // multiple ways to integrate SwiftUI depending on iOS version. Did not want to assume we could bump target to 16, but here's code already for the fictional time when that could happen
            if #available(iOS 16.0, *) {
                cell.contentConfiguration = UIHostingConfiguration {
                    WordDefinitionView(wordResult: wr, defIdx: indexPath.row)
                }
            } else {
                // Load SwiftUI into a controller, add that VC view into a cell subvew.
                let swiftUICellViewController = UIHostingController(rootView: WordDefinitionView(wordResult: wr, defIdx: indexPath.row))
                
                cell.contentView.addSubview(swiftUICellViewController.view)
                swiftUICellViewController.view.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addConstraint(NSLayoutConstraint(item: swiftUICellViewController.view!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
                cell.contentView.addConstraint(NSLayoutConstraint(item: swiftUICellViewController.view!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
                cell.contentView.addConstraint(NSLayoutConstraint(item: swiftUICellViewController.view!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
                cell.contentView.addConstraint(NSLayoutConstraint(item: swiftUICellViewController.view!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
                
                swiftUICellViewController.view.layoutIfNeeded()
            }
        }
        cell.backgroundColor = .clear
        return cell
    }
}
