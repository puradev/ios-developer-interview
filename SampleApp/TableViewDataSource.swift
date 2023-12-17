//
//  TableViewDataSource.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation
import UIKit


class TableViewDataSource: NSObject {
    enum State {
        case empty
        case entries([WordEntry])
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
    func numberOfSections(in tableView: UITableView) -> Int {
        guard case let State.entries(entries) = state  else {
            return 0
        }
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case let State.entries(entries) = state  else {
            return 0
        }
        return entries[section].pronunciationsCount + entries[section].shortDefinitions.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard case let State.entries(entries) = state  else {
            return nil
        }
        return entries[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let State.entries(entries) = state  else {
            return UITableViewCell()
        }
        let wordEntry = entries[indexPath.section]
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        
        if wordEntry.pronunciationsCount > 0, indexPath.row >= 0, indexPath.row < wordEntry.pronunciationsCount {
            cell.textLabel?.text = "pronunciation:"
            if let pronunciation = wordEntry.headwordInformation.pronunciations?[indexPath.row].formatMerriamWebster {
                cell.detailTextLabel?.text = pronunciation
            }
        } else {
            cell.textLabel?.text = "definition:"
            cell.detailTextLabel?.text = wordEntry.shortDefinitions[indexPath.row - wordEntry.pronunciationsCount]
        }
        return cell
    }
}
