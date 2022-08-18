//
//  UIView+PetitAmi.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/18/22.
//

import UIKit

extension UIView {
    public func setRoundCorners(cornerRadius: CGFloat = 4) {
         self.layer.cornerRadius = cornerRadius
    }

    @discardableResult
    func addSubviews(_ views: [UIView]) -> Self {
        for view in views {
            view.autoResizingOff()
            addSubview(view)
        }
        return self
    }

    @discardableResult
    func autoResizingOff() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    @discardableResult
    func topToBottom(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: element, attribute: .bottom, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func bottomToTop(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: element, attribute: .top, multiplier: multiplier, constant: -margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func leadingToTrailing(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relation, toItem: element, attribute: .trailing, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func trailingToLeading(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: relation, toItem: element, attribute: .leading, multiplier: multiplier, constant: -margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func topToTop(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: element, attribute: .top, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func bottomToBottom(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: element, attribute: .bottom, multiplier: multiplier, constant: -margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func leadingToLeading(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relation, toItem: element, attribute: .leading, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func trailingToTrailing(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: relation, toItem: element, attribute: .trailing, multiplier: multiplier, constant: -margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    // MARK: - Width and Height
    @discardableResult
    func widthTo(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: self, attribute: .width, multiplier: 0, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func heightTo(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: self, attribute: .height, multiplier: 0, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func widthOf(_ element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: element, attribute: .width, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func heightOf(_ element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: element, attribute: .height, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    // MARK: - Centers
    @discardableResult
    func centerHorizontal(to element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: relation, toItem: element, attribute: .centerX, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func centerVertical(to element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: relation, toItem: element, attribute: .centerY, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func centerTo(to element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, isActive: Bool = true) -> Self {
        centerHorizontal(to: element, relation: relation, multiplier: multiplier, priority: priority, constant: constant, isActive: isActive)
        centerVertical(to: element, relation: relation, multiplier: multiplier, priority: priority, constant: constant, isActive: isActive)
        return self
    }
}
