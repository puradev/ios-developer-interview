//
//  WordDefinitionTableViewCell.swift
//  SampleApp
//
//  Created by Ralston Goes on 2/6/24.
//

import UIKit

class WordDefinitionTableViewCell: UITableViewCell {

    static let reuseID = String(describing: WordDefinitionTableViewCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
    
}
