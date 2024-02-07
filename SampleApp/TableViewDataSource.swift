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
        case word(Word)
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
        return word.definitions.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let State.word(word) = state else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        let wordString = "word:"
        let definitionString = "definition \(indexPath.row):"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordDefinitionTableViewCell.reuseID, for: indexPath) as? WordDefinitionTableViewCell else {
            print("TableViewError: Couldn't dequeue reusable cell \(WordDefinitionTableViewCell.reuseID)")
            return UITableViewCell()
        }
        if indexPath.row == 0 {
            cell.configure(title: wordString, content: word.text)
        } else {
            cell.configure(title: definitionString, content: word.definitions[indexPath.row - 1])
        }
        return cell
    }
}
