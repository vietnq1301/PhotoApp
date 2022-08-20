//
//  UIView+Ext.swift
//  MagicGatheringUIKit
//
//  Created by Nguyễn Việt on 17/07/2022.
//

import UIKit

extension UIView {
    var topLeft:     CACornerMask { return .layerMinXMinYCorner }
    var topRight:    CACornerMask { return .layerMaxXMinYCorner }
    var bottomLeft:  CACornerMask { return .layerMinXMaxYCorner }
    var bottomRight: CACornerMask { return .layerMaxXMaxYCorner }
    
    func round(corners: Corners, radius: CGFloat? = 8.0) {
        
        var maskedCorners: CACornerMask = []
        
        if corners.contains(.topLeft) {
            maskedCorners.update(with: topLeft)
        }

        if corners.contains(.topRight) {
            maskedCorners.update(with: topRight)
        }

        if corners.contains(.bottomLeft) {
            maskedCorners.update(with: bottomLeft)
        }

        if corners.contains(.bottomRight) {
            maskedCorners.update(with: bottomRight)
        }
        
        clipsToBounds       = true
        layer.cornerRadius  = radius ?? 8.0
        layer.maskedCorners = maskedCorners
    }
}


struct Corners: OptionSet {
    let rawValue: Int
    
    static let topLeft         = Corners(rawValue: 1)
    static let topRight        = Corners(rawValue: 2)
    static let bottomLeft      = Corners(rawValue: 3)
    static let bottomRight     = Corners(rawValue: 4)
    
    static let top: Corners    = [.topLeft, .topRight]
    static let bottom: Corners = [.bottomLeft, .bottomRight]
    static let left: Corners   = [.topLeft, .bottomLeft]
    static let right: Corners  = [.topRight, .bottomRight]
    static let all: Corners    = [.topLeft, .topRight, .bottomLeft, .bottomRight]
}

extension UIView {
    enum ViewSide {
        case top
        case left
        case bottom
        case right
        case all
    }

    func addBorders(to sides: [ViewSide], in color: UIColor, width: CGFloat) {
        sides.forEach { addBorder(to: $0, in: color, width: width) }
    }

    func addBorder(to side: ViewSide, in color: UIColor, width: CGFloat) {
        switch side {
        case .top:
            addTopBorder(in: color, width: width)
        case .left:
            addLeftBorder(in: color, width: width)
        case .bottom:
            addBottomBorder(in: color, width: width)
        case .right:
            addRightBorder(in: color, width: width)
        case .all:
            addTopBorder(in: color, width: width)
        }
    }

    func addTopBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        addSubview(border)
    }

    func addBottomBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(border)
    }

    func addLeftBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        addSubview(border)
    }
    
    func addAllBorder(in color: UIColor?, width borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color?.cgColor
    }
}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}

extension UIStackView {
    func addArrangedSubview(_ views: [UIView]) {
        views.forEach { view in
            self.addArrangedSubview(view)
        }
    }
}
