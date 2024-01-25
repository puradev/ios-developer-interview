//
//  DictionaryTableViewCell.swift
//  SampleApp
//
//  Created by Drew Needham-Wood on 1/25/24.
//

import Foundation
import UIKit

enum DictionaryTableCellType {
    case word
    case definition
}

class DictionaryTableViewCell: UITableViewCell {
    var stackView = UIStackView()
    var titleLabel = UILabel()
    var valueLabel = UILabel()
    var spacer = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupAppearance() {
        contentView.addSubviewWithFillConstraints(subview: stackView, margin: 20)
        
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .top
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)

        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        valueLabel.numberOfLines = 0
        valueLabel.lineBreakMode = .byWordWrapping
        valueLabel.textColor = .gray
        valueLabel.textAlignment = .left
    }

    func configure(cellType: DictionaryTableCellType, value: String) {
        switch cellType {
        case .word:
            titleLabel.text = "Word:"
            stackView.insertArrangedSubview(spacer, at: 1)
        case .definition:
            titleLabel.text = "Definition:"
            stackView.insertArrangedSubview(spacer, at: 2)
        }
        
        valueLabel.text = value
    }
}
