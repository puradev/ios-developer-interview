//
//  TableViewDataSource.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation
import UIKit



  class TableViewDataSource: NSObject{
    
      
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


extension TableViewDataSource: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        
        guard case let State.word(word) = state  else {
            return 0
        }
        let data = [1, word.definitions.count]
        return data[section]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard case let State.word(word) = state  else {
            return UICollectionViewCell()
        }
        
        if indexPath.section == 0 {
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionCell
            cell.wordInitUI()
            cell.setWordText(word.text)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionCell
            cell.definitionInitUI()
            cell.setText(word.definitions[indexPath.row])
            return cell
        }
    }
    
}

//extension TableViewDataSource: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard case let State.word(word) = state  else {
//            return 0
//        }
//        return word.definitions.count + 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard case let State.word(word) = state  else {
//            return UITableViewCell()
//        }
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
//        cell.selectionStyle = .none
//
//        if indexPath.row == 0 {
//            cell.textLabel?.text = "word:"
//            cell.detailTextLabel?.text = word.text
//        } else {
//            cell.textLabel?.text = "definition:"
//            cell.detailTextLabel?.text = word.definitions[indexPath.row - 1]
//        }
//        return cell
//    }
//}
