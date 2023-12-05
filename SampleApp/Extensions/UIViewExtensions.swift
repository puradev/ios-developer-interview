//
//  UIViewExtensions.swift
//  SampleApp
//
//  Created by Sean Machen on 12/1/23.
//

import UIKit

extension UIView {
    /// Constrains the view to the bounds of the given parent view.
    /// - Parameter parentView: The parent view to constrain to.
    func constrain(to parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
    }
}
