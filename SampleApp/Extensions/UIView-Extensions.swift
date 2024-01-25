//
//  UIView-Extensions.swift
//  SampleApp
//
//  Created by Drew Needham-Wood on 1/24/24.
//

import Foundation
import UIKit

extension UIView {
    func addSubviewWithFillConstraints(subview: UIView, margin: CGFloat = 0) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: self.topAnchor, constant: margin),
            subview.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -margin),
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin),
            subview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margin)
        ])
    }
    
    func addSubviewWithFillConstraintsAndDisregardSafeArea(subview: UIView) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: self.topAnchor),
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
