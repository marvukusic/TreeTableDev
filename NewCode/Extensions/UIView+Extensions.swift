//
//  UIView+Extensions.swift
//  Myo
//
//  Created by Robert Majtan on 16/07/2020.
//  Copyright © 2020 Myo GmbH. All rights reserved.
//

import UIKit

public enum BorderSide {
    case top, bottom, left, right
}

extension UIView {
    public func addBorder(side: BorderSide, color: UIColor, width: CGFloat) {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = color
        self.addSubview(border)

        let topConstraint = topAnchor.constraint(equalTo: border.topAnchor)
        let rightConstraint = trailingAnchor.constraint(equalTo: border.trailingAnchor)
        let bottomConstraint = bottomAnchor.constraint(equalTo: border.bottomAnchor)
        let leftConstraint = leadingAnchor.constraint(equalTo: border.leadingAnchor)
        let heightConstraint = border.heightAnchor.constraint(equalToConstant: width)
        let widthConstraint = border.widthAnchor.constraint(equalToConstant: width)


        switch side {
        case .top:
            NSLayoutConstraint.activate([leftConstraint, topConstraint, rightConstraint, heightConstraint])
        case .right:
            NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, widthConstraint])
        case .bottom:
            NSLayoutConstraint.activate([rightConstraint, bottomConstraint, leftConstraint, heightConstraint])
        case .left:
            NSLayoutConstraint.activate([bottomConstraint, leftConstraint, topConstraint, widthConstraint])
        }
    }
}


extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            var masked = CACornerMask()
            if corners.contains(.topLeft) { masked.insert(.layerMinXMinYCorner) }
            if corners.contains(.topRight) { masked.insert(.layerMaxXMinYCorner) }
            if corners.contains(.bottomLeft) { masked.insert(.layerMinXMaxYCorner) }
            if corners.contains(.bottomRight) { masked.insert(.layerMaxXMaxYCorner) }
            self.layer.maskedCorners = masked
        }
        else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

extension UIView {
    @discardableResult func addTapGesture(target: AnyObject?, callback: Selector, numberOfTaps: Int) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: target, action: callback)
        tap.numberOfTapsRequired = numberOfTaps
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        return tap
    }

    func animBottomShow() {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear],
                           animations: {
                            self.center.y -= self.bounds.height - 5
                            self.layoutIfNeeded()
            }, completion: nil)

        self.isHidden = false
    }

    func animBottomHide() {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear],
                           animations: {
                            self.center.y += self.bounds.height - 5 // - 5 for the bottom corner curve on SE and iPhone 8
                            self.layoutIfNeeded()

            }, completion: {(_ completed: Bool) -> Void in
                self.isHidden = true
            })
    }
}

extension UIView {
    func setBorder(radius: CGFloat, color: UIColor = UIColor.clear) -> UIView {
        let roundView: UIView = self
        roundView.layer.cornerRadius = CGFloat(radius)
        roundView.layer.borderWidth = 1
        roundView.layer.borderColor = color.cgColor
        roundView.clipsToBounds = true
        return roundView
    }

    func setBorder(color: UIColor = .clear) {
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = color.cgColor
    }

    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10, height: -5)
        layer.shadowRadius = 1

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIView {
    func pinEdges(to other: UIView, offset: CGFloat = 0, fromTop: CGFloat = 0, fromBottom: CGFloat = 0, fromLeft: CGFloat = 0, fromRight: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor   .constraint(equalTo: other.leadingAnchor, constant: offset + fromLeft).isActive = true
        trailingAnchor  .constraint(equalTo: other.trailingAnchor, constant: -offset - fromRight).isActive = true
        topAnchor       .constraint(equalTo: other.topAnchor, constant: offset + fromTop).isActive = true
        bottomAnchor    .constraint(equalTo: other.bottomAnchor, constant: -offset - fromBottom).isActive = true
    }
}

extension UIView {
    static func loadFromNib(owner: Any?) -> Self {
        let nib = UINib(nibName: String(describing: self), bundle: nil)
        let view = nib.instantiate(withOwner: owner, options: nil).first as! Self
        return view
    }
}
