//
//  Utils.swift
//  SampleApp
//
//  Created by MacBook on 26/01/23.
//

import Foundation
import UIKit

public enum State {
    case empty
    case word(Word)
}

let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height

public enum Anchor { case left, top, right, bottom }

public extension UIView {

    static func topPadding() -> CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
        } else {
            return 0.0
        }
    }

    static func bottomPadding() -> CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
        } else {
            return 0.0
        }
    }

    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    func addAnchorsWithMargin(_ margin: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: margin).isActive = true
        self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: margin).isActive = true
        self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor, constant: -margin).isActive = true
        self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: -margin).isActive = true
    }

    /**
     Description: Centers the view in the superview, using the superview's **size** and **XYAxis** position, not the left, top, right, bottom anchors to avoid issues with the *UISCrollViews*
     Parameters: None
     */
    func addAnchorsCenterAndFillContainerWithSize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor).isActive = true
    }

    /**
     Adds 2 optional alignment parameterts (**centerX**, **centerY**), 2 optional size dimensions (**width** and **height**) and up to 4 border anchors **.left**, **.top**, **.right** and **.bottom**. One of them (defined in **withAnchor** can be relative to another view

     - Parameter centerX: **Bool** value (or *nil*) to define if the view should be centered **horizontally** to the superview. (optional)
     - Parameter centerY: **Bool** value (or *nil*) to define if the view should be centered **vertically** to the superview. (optional)
     - Parameter width: The **width** of the view (optional)
     - Parameter width: The **width** of the view (optional)
     - Parameter height: The **height** of the view (optional)
     - Parameter left: The **left** margin to the superview
     - Parameter top: The **top** margin to the superview
     - Parameter right: The **right** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter bottom: The **bottom** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter withAnchor: The **Anchor** type that is relative to the **relativeToView** view. *This parameter can be omited*
     - Parameter relativeToView: The **UIView** object that is the reference for the **withAnchor** anchor. *This parameter can be omited*

     - Returns: None
     */
    func addAnchorsAndCenter(centerX: Bool?, centerY: Bool?, width: CGFloat?, height: CGFloat?, left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {

        self.translatesAutoresizingMaskIntoConstraints = false
        if centerX != nil {
            if centerX! == true {
                self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
            }
        }
        if centerY != nil {
            if centerY! == true {
                self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor).isActive = true
            }
        }

        self.addAnchorsAndSize(width: width, height: height, left: left, top: top, right: right, bottom: bottom, withAnchor: withAnchor, relativeToView: relativeToView)
    }

    /**
     Adds 2 optional size dimensions (**width** and **height**) and up to 4 border anchors **.left**, **.top**, **.right** and **.bottom**. One of them (defined in **withAnchor** can be relative to another view

     - Parameter width: The **width** of the view (optional)
     - Parameter height: The **height** of the view (optional)
     - Parameter left: The **left** margin to the superview
     - Parameter top: The **top** margin to the superview
     - Parameter right: The **right** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter bottom: The **bottom** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter withAnchor: The **Anchor** type that is relative to the **relativeToView** view. *This parameter can be omited*
     - Parameter relativeToView: The **UIView** object that is the reference for the **withAnchor** anchor. *This parameter can be omited*

     - Returns: None
     */
    func addAnchorsAndSize(width: CGFloat?, height: CGFloat?, left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {

        self.translatesAutoresizingMaskIntoConstraints = false
        if width != nil {
            self.widthAnchor.constraint(equalToConstant: width!).isActive = true
        }
        if height != nil {
            self.heightAnchor.constraint(equalToConstant: height!).isActive = true
        }
        self.addAnchors(left: left, top: top, right: right, bottom: bottom, withAnchor: withAnchor, relativeToView: relativeToView)
    }

    /**
     Adds up to 4 border anchors **.left**, **.top**, **.right** and **.bottom**. One of them (defined in **withAnchor** can be relative to another view

     - Parameter left: The **left** margin to the superview
     - Parameter top: The **top** margin to the superview
     - Parameter right: The **right** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter bottom: The **bottom** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter withAnchor: The **Anchor** type that is relative to the **relativeToView** view. *This parameter can be omited*
     - Parameter relativeToView: The **UIView** object that is the reference for the **withAnchor** anchor. *This parameter can be omited*

     - Returns: None
     */
    func addAnchors(left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {

        self.translatesAutoresizingMaskIntoConstraints = false
        let superView = self.superview!
        if withAnchor != nil && relativeToView != nil {
            /**
             * Anchors relative to oposite anchors of reference view
             **/
            switch withAnchor! {
            case .left:
                if left != nil {
                    self.leftAnchor.constraint(equalTo: relativeToView!.rightAnchor, constant: left!).isActive = true
                }
            case .top:
                if top != nil {
                    self.topAnchor.constraint(equalTo: relativeToView!.bottomAnchor, constant: top!).isActive = true
                }
            case .right:
                if right != nil {
                    self.rightAnchor.constraint(equalTo: relativeToView!.leftAnchor, constant: -right!).isActive = true
                }
            case .bottom:
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: relativeToView!.topAnchor, constant: -bottom!).isActive = true
                }
            }
        }

        /**
         * Anchors relative to same anchors of superview
         **/
        if let _anchor = withAnchor {
            if _anchor == .left {
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .top {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .right {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
                }
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .bottom {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: (left!)).isActive = true
                }
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
            }
        } else {
            if left != nil {
                self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
            }
            if top != nil {
                self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
            }
            if right != nil {
                self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
            }
            if bottom != nil {
                self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
            }
        }
    }
}


struct LAColors {
    static let whiteHighlighted = UIColor.init(red: 0.67, green: 0.67, blue: 0.69, alpha: 1.00)

    static let darkGreen = UIColor(red: 0.832, green: 0.867, blue: 0.332, alpha: 1)

    static let ligthGreen = UIColor(red: 0.89, green: 0.929, blue: 0.333, alpha: 1)
    static let darkBlueHighlighted = UIColor.init(red: 0.15, green: 0.19, blue: 0.24, alpha: 1)
    static let darkGradientBlue = UIColor.init(red: 0.07, green: 0.29, blue: 0.36, alpha: 1)
    static let lightBlue = UIColor.init(red: 0.36, green: 0.53, blue: 0.63, alpha: 1)

    static let mediumBlue =  UIColor(red: 0, green: 0.702, blue: 0.902, alpha: 1)

    static let calypso = UIColor.init(red: 0.25, green: 0.43, blue: 0.55, alpha: 1.00)

    static let green = UIColor.init(red: 0.36, green: 0.72, blue: 0.41, alpha: 1)
    static let greenHighlighted = UIColor.init(red: 0.30, green: 0.65, blue: 0.35, alpha: 1)
    static let aquarela = UIColor(red: 0.071, green: 0.616, blue: 0.922, alpha: 1)

    static let blue = UIColor(red: 0.22, green: 0.71, blue: 0.85, alpha: 1.00)

    static let orange = UIColor(red: 1.00, green: 0.65, blue: 0.14, alpha: 1.00)

    static let greenDusky = UIColor(red: 0.388, green: 0.725, blue: 0.365, alpha: 1)

    static let aquarelaHighlighted = UIColor.init(red: 0.00, green: 0.65, blue: 0.73, alpha: 1)
    static let pistachio = UIColor.init(red: 0.58, green: 0.79, blue: 0.37, alpha: 1.00)
    static let bilbao = UIColor.init(red: 0.27, green: 0.49, blue: 0.16, alpha: 1.00)

    static let dangerRed = UIColor.init(red: 1.00, green: 0.39, blue: 0.41, alpha: 1)
    static let dangerRedHighlighted = UIColor.init(red: 0.70, green: 0.40, blue: 0.42, alpha: 1)
    static let geraldine = UIColor.init(red: 1.00, green: 0.56, blue: 0.57, alpha: 1.00)
    static let appleRed = UIColor.init(red: 0.86, green: 0.04, blue: 0.18, alpha: 1.00)

    static let lightGray = UIColor.init(red: 0.89, green: 0.89, blue: 0.89, alpha: 1)
    static let darkGray = UIColor.init(red: 0.65, green: 0.65, blue: 0.66, alpha: 1.00)
    static let viewBackground = UIColor.init(red: 0.95, green: 0.95, blue: 0.96, alpha: 1)
    static let cellHighlighted = UIColor.init(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
    static let labelGray = UIColor.init(red: 0.67, green: 0.68, blue: 0.69, alpha: 1)
    static let dummyGray = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    static let iron = UIColor.init(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.00)
    static let chicago = UIColor.init(red: 0.36, green: 0.36, blue: 0.36, alpha: 1.00)

    static let yellow = UIColor(red: 0.992, green: 0.851, blue: 0.188, alpha: 1)
    static let colorStar = UIColor(red: 0.832, green: 0.867, blue: 0.332, alpha: 1)
    static let mustard = UIColor.init(red: 1.00, green: 0.84, blue: 0.34, alpha: 1.00)
    static let brown = UIColor.init(red: 0.60, green: 0.39, blue: 0.21, alpha: 1.00)

    static let ligthBrown = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
    static let onyx = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    static let opacityWhite = UIColor.init(white: 1, alpha: 0.3)
    static let opacityBlack = UIColor.init(white: 0, alpha: 0.3)
    static let opacityMediumBlack = UIColor.init(white: 0, alpha: 0.6)

    static let textBlack = UIColor.black
    static let white = UIColor.white

    
    static let gradient: CAGradientLayer = {
        let l = CAGradientLayer()
        l.colors = [LAColors.ligthGreen.cgColor, LAColors.aquarela.cgColor]
        l.locations = [-0.3, 1]
        l.startPoint = CGPoint(x: 0.70, y: 0.80)
        l.endPoint = CGPoint(x: 1.0, y: 0.0)
        return l
    }()
}


extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: Double) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }

}

extension CACornerMask {
    public static var leftBottom     : CACornerMask { get { return .layerMinXMaxYCorner}}
    public static var rightBottom    : CACornerMask { get { return .layerMaxXMaxYCorner}}
    public static var leftTop        : CACornerMask { get { return .layerMaxXMinYCorner}}
    public static var rightTop       : CACornerMask { get { return .layerMinXMinYCorner}}
}

extension CALayer {
    @available(iOS 11.0, *)
    func roundCorners(_ mask:CACornerMask,corner:CGFloat) {
        self.maskedCorners = mask
        self.cornerRadius = corner
    }
}


extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}


