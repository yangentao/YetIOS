//
// Created by entaoyang on 2019-02-14.
// Copyright (c) 2019 yet.net. All rights reserved.
//

import Foundation
import UIKit





public extension UIView {

    var layout: YetLayout {
        YetLayout(self)
    }

    func layout(block: (YetLayout) -> Void) {
        block(self.layout)
    }



}


public class YetLayout {
    private unowned var view: UIView

    public init(_ view: UIView) {
        self.view = view
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
}

public extension YetLayout {

    func removeAll() {
        self.view.removeAllConstraints()
    }

    func remove(ident: String) {
        self.view.removeConstraint(ident: ident)
    }

    var left: YetLayoutRel {
        YetLayoutRel(self.view, .left)
    }

    var right: YetLayoutRel {
        YetLayoutRel(self.view, .right)
    }

    var top: YetLayoutRel {
        YetLayoutRel(self.view, .top)
    }

    var bottom: YetLayoutRel {
        YetLayoutRel(self.view, .bottom)
    }

    var leading: YetLayoutRel {
        YetLayoutRel(self.view, .leading)
    }

    var trailing: YetLayoutRel {
        YetLayoutRel(self.view, .trailing)
    }

    var width: YetLayoutRel {
        YetLayoutRel(self.view, .width)
    }

    var height: YetLayoutRel {
        YetLayoutRel(self.view, .height)
    }

    var centerX: YetLayoutRel {
        YetLayoutRel(self.view, .centerX)
    }

    var centerY: YetLayoutRel {
        YetLayoutRel(self.view, .centerY)
    }

    var lastBaseline: YetLayoutRel {
        YetLayoutRel(self.view, .lastBaseline)
    }

    var firstBaseline: YetLayoutRel {
        YetLayoutRel(self.view, .firstBaseline)
    }

    var leftMargin: YetLayoutRel {
        YetLayoutRel(self.view, .leftMargin)
    }

    var rightMargin: YetLayoutRel {
        YetLayoutRel(self.view, .rightMargin)
    }

    var topMargin: YetLayoutRel {
        YetLayoutRel(self.view, .topMargin)
    }

    var bottomMargin: YetLayoutRel {
        YetLayoutRel(self.view, .bottomMargin)
    }

    var leadingMargin: YetLayoutRel {
        YetLayoutRel(self.view, .leadingMargin)
    }

    var trailingMargin: YetLayoutRel {
        YetLayoutRel(self.view, .trailingMargin)
    }

    var centerYWithinMargins: YetLayoutRel {
        YetLayoutRel(self.view, .centerYWithinMargins)
    }

}

public class YetLayoutRel {
    private unowned var view: UIView
    private let attr: NSLayoutConstraint.Attribute

    fileprivate init(_ view: UIView, _ attr: NSLayoutConstraint.Attribute) {
        self.view = view
        self.attr = attr
    }
}

public extension YetLayoutRel {

    func eq(_ c: CGFloat) -> YetLayoutAttrNone {
        YetLayoutAttrNone(view, attr, .equal, c)
    }

    func ge(_ c: CGFloat) -> YetLayoutAttrNone {
        YetLayoutAttrNone(view, attr, .greaterThanOrEqual, c)
    }

    func le(_ c: CGFloat) -> YetLayoutAttrNone {
        YetLayoutAttrNone(view, attr, .lessThanOrEqual, c)
    }

    func eq(_ v: UIView) -> YetLayoutAttrOther {
        YetLayoutAttrOther(view, attr, .equal, v)
    }

    func ge(_ v: UIView) -> YetLayoutAttrOther {
        YetLayoutAttrOther(view, attr, .greaterThanOrEqual, v)
    }

    func le(_ v: UIView) -> YetLayoutAttrOther {
        YetLayoutAttrOther(view, attr, .lessThanOrEqual, v)
    }

    var eqParent: YetLayoutAttrOther {
        YetLayoutAttrOther(view, attr, .equal, view.superview!)
    }
    var geParent: YetLayoutAttrOther {
        YetLayoutAttrOther(view, attr, .greaterThanOrEqual, view.superview!)
    }
    var leParent: YetLayoutAttrOther {
        YetLayoutAttrOther(view, attr, .lessThanOrEqual, view.superview!)
    }
}

public class YetLayoutAttrBase {
    fileprivate var view: UIView
    fileprivate let attr: NSLayoutConstraint.Attribute
    fileprivate let rel: NSLayoutConstraint.Relation
    fileprivate var view2: UIView? = nil
    fileprivate var attr2: NSLayoutConstraint.Attribute = .notAnAttribute
    fileprivate var multi: CGFloat = 1
    fileprivate var constant: CGFloat = 0
    fileprivate var priority: UILayoutPriority = UILayoutPriority.required
    fileprivate var idName: String? = nil

    fileprivate init(_ view: UIView, _ attr: NSLayoutConstraint.Attribute, _ rel: NSLayoutConstraint.Relation) {
        self.view = view
        self.attr = attr
        self.rel = rel
    }

    private func findOld() -> NSLayoutConstraint? {
        let ls = self.view.layoutConstraintItems.items.filter { (n: NSLayoutConstraint) in
            n.isActive && n.firstItem === view && n.firstAttribute == attr && n.relation == rel
        }
        if !ls.isEmpty {
            return ls.first
        }
        return nil
    }

    public func update() {
        if let c = findOld() {
            c.constant = constant
            view.setNeedsUpdateConstraints()
            view.superview?.setNeedsUpdateConstraints()
            view.superview?.setNeedsLayout()
        }
    }

    public func remove() {
        let c = self.view.layoutConstraintItems.items.removeFirstIf { (n: NSLayoutConstraint) in
            n.firstItem === view && n.firstAttribute == attr && n.relation == rel
        }
        c?.isActive = false
    }

    @discardableResult
    public func active() -> NSLayoutConstraint {
        let n = NSLayoutConstraint(item: self.view, attribute: attr, relatedBy: rel, toItem: view2, attribute: attr2, multiplier: multi, constant: constant)
        n.priority = priority
        if let name = idName {
            n.identifier = name
        }
        n.isActive = true
        self.view.layoutConstraintItems.items.append(n)
        return n
    }
}

public class YetLayoutAttrNone: YetLayoutAttrBase {

    fileprivate init(_ view: UIView, _ attr: NSLayoutConstraint.Attribute, _ rel: NSLayoutConstraint.Relation, _ c: CGFloat) {
        super.init(view, attr, rel)
        self.constant = c
    }

    public func priority(_ p: UILayoutPriority) -> YetLayoutAttrNone {
        self.priority = p
        return self
    }

    public func priority(_ n: Int) -> YetLayoutAttrNone {
        self.priority = UILayoutPriority(rawValue: Float(n))
        return self
    }

    public var priorityLow: YetLayoutAttrNone {
        self.priority = UILayoutPriority.defaultLow
        return self
    }
    public var priorityHigh: YetLayoutAttrNone {
        self.priority = UILayoutPriority.defaultHigh
        return self
    }
    public var priorityFittingSize: YetLayoutAttrNone {
        self.priority = UILayoutPriority.fittingSizeLevel
        return self
    }

    public func ident(_ name: String) -> YetLayoutAttrNone {
        self.idName = name
        return self
    }
}

public class YetLayoutAttrOther: YetLayoutAttrBase {

    fileprivate init(_ view: UIView, _ attr: NSLayoutConstraint.Attribute, _ rel: NSLayoutConstraint.Relation, _ view2: UIView) {
        super.init(view, attr, rel)
        self.view2 = view2
        self.attr2 = self.attr
    }

}

public extension YetLayoutAttrOther {

    func priority(_ p: UILayoutPriority) -> YetLayoutAttrOther {
        self.priority = p
        return self
    }

    func priority(_ n: Int) -> YetLayoutAttrOther {
        self.priority = UILayoutPriority(rawValue: Float(n))
        return self
    }

    var priorityLow: YetLayoutAttrOther {
        self.priority = UILayoutPriority.defaultLow
        return self
    }
    var priorityHigh: YetLayoutAttrOther {
        self.priority = UILayoutPriority.defaultHigh
        return self
    }
    var priorityFittingSize: YetLayoutAttrOther {
        self.priority = UILayoutPriority.fittingSizeLevel
        return self
    }

    func ident(_ name: String) -> YetLayoutAttrOther {
        self.idName = name
        return self
    }

    func divided(_ m: CGFloat) -> YetLayoutAttrOther {
        self.multi = 1 / m
        return self
    }

    func multi(_ m: CGFloat) -> YetLayoutAttrOther {
        self.multi = m
        return self
    }

    func offset(_ c: CGFloat) -> YetLayoutAttrOther {
        self.constant = c
        return self
    }

    var left: YetLayoutAttrOther {
        attr2 = .left
        return self
    }

    var right: YetLayoutAttrOther {
        attr2 = .right
        return self
    }

    var top: YetLayoutAttrOther {
        attr2 = .top
        return self
    }

    var bottom: YetLayoutAttrOther {
        attr2 = .bottom
        return self
    }

    var leading: YetLayoutAttrOther {
        attr2 = .leading
        return self
    }

    var trailing: YetLayoutAttrOther {
        attr2 = .trailing
        return self
    }

    var width: YetLayoutAttrOther {
        attr2 = .width
        return self
    }

    var height: YetLayoutAttrOther {
        attr2 = .height
        return self
    }

    var centerX: YetLayoutAttrOther {
        attr2 = .centerX
        return self
    }

    var centerY: YetLayoutAttrOther {
        attr2 = .centerY
        return self
    }

    var lastBaseline: YetLayoutAttrOther {
        attr2 = .lastBaseline
        return self
    }

    var firstBaseline: YetLayoutAttrOther {
        attr2 = .firstBaseline
        return self
    }

    var leftMargin: YetLayoutAttrOther {
        attr2 = .leftMargin
        return self
    }

    var rightMargin: YetLayoutAttrOther {
        attr2 = .rightMargin
        return self
    }

    var topMargin: YetLayoutAttrOther {
        attr2 = .topMargin
        return self
    }

    var bottomMargin: YetLayoutAttrOther {
        attr2 = .bottomMargin
        return self
    }

    var leadingMargin: YetLayoutAttrOther {
        attr2 = .leadingMargin
        return self
    }

    var trailingMargin: YetLayoutAttrOther {
        attr2 = .trailingMargin
        return self
    }

    var centerYWithinMargins: YetLayoutAttrOther {
        attr2 = .centerYWithinMargins
        return self
    }

}

public extension YetLayout {
    @discardableResult
    func centerXOf(_ v: UIView, _ offset: CGFloat = 0) -> YetLayout {
        self.centerX.eq(v).offset(offset).active()
        return self
    }

    @discardableResult
    func centerYOf(_ v: UIView, _ offset: CGFloat = 0) -> YetLayout {
        self.centerY.eq(v).offset(offset).active()
        return self
    }

    @discardableResult
    func toLeftOf(_ v: UIView, _ offset: CGFloat = 0) -> YetLayout {
        self.right.eq(v).left.offset(offset).active()
        return self
    }

    @discardableResult
    func toRightOf(_ v: UIView, _ offset: CGFloat = 0) -> YetLayout {
        self.left.eq(v).right.offset(offset).active()
        return self
    }

    @discardableResult
    func below(_ v: UIView, _ offset: CGFloat = 0) -> YetLayout {
        self.top.eq(v).bottom.offset(offset).active()
        return self
    }

    @discardableResult
    func above(_ v: UIView, _ offset: CGFloat = 0) -> YetLayout {
        self.bottom.eq(v).top.offset(offset).active()
        return self
    }

    @discardableResult
    func widthOf(_ v: UIView) -> YetLayout {
        self.width.eq(v).active()
        return self
    }

    @discardableResult
    func heightOf(_ v: UIView) -> YetLayout {
        self.height.eq(v).active()
        return self
    }

    @discardableResult
    func leftOf(_ v: UIView) -> YetLayout {
        self.left.eq(v).active()
        return self
    }

    @discardableResult
    func rightOf(_ v: UIView) -> YetLayout {
        self.right.eq(v).active()
        return self
    }

    @discardableResult
    func topOf(_ v: UIView) -> YetLayout {
        self.top.eq(v).active()
        return self
    }

    @discardableResult
    func bottomOf(_ v: UIView) -> YetLayout {
        self.bottom.eq(v).active()
        return self
    }

    @discardableResult
    func centerParent() -> YetLayout {
        self.centerXParent()
        self.centerYParent()
        return self
    }

    @discardableResult
    func centerXParent(_ offset: CGFloat = 0) -> YetLayout {
        self.centerX.eqParent.offset(offset).active()
        return self
    }

    @discardableResult
    func centerYParent(_ offset: CGFloat = 0) -> YetLayout {
        self.centerY.eqParent.offset(offset).active()
        return self
    }

    @discardableResult
    func fillX() -> YetLayout {
        self.fillX(0, 0)
    }

    @discardableResult
    func fillX(_ leftOffset: CGFloat, _ rightOffset: CGFloat) -> YetLayout {
        self.leftParent(leftOffset)
        return self.rightParent(rightOffset)
    }

    @discardableResult
    func fillY() -> YetLayout {
        self.fillY(0, 0)
    }

    @discardableResult
    func fillY(_ topOffset: CGFloat, _ bottomOffset: CGFloat) -> YetLayout {
        self.topParent(topOffset)
        return self.bottomParent(bottomOffset)
    }

    @discardableResult
    func fill() -> YetLayout {
        fillX()
        fillY(0, 0)
        return self
    }

    @discardableResult
    func topParent(_ n: CGFloat = 0) -> YetLayout {
        self.top.eqParent.offset(n).active()
        return self
    }

    @discardableResult
    func bottomParent(_ n: CGFloat = 0) -> YetLayout {
        self.bottom.eqParent.offset(n).active()
        return self
    }

    @discardableResult
    func leftParent(_ n: CGFloat = 0) -> YetLayout {
        self.left.eqParent.offset(n).active()
        return self
    }

    @discardableResult
    func rightParent(_ n: CGFloat = 0) -> YetLayout {
        self.right.eqParent.offset(n).active()
        return self
    }

    @discardableResult
    func heightLe(_ w: CGFloat) -> YetLayout {
        self.height.le(w).active()
        return self
    }

    @discardableResult
    func heightGe(_ w: CGFloat) -> YetLayout {
        self.height.ge(w).active()
        return self
    }

    @discardableResult
    func height(_ w: CGFloat) -> YetLayout {
        self.height.eq(w).active()
        return self
    }

    @discardableResult
    func heightEdit() -> YetLayout {
        self.height(YetLayoutConst.editHeight)
        return self
    }

    @discardableResult
    func heightText() -> YetLayout {
        self.height(YetLayoutConst.textHeight)
        return self
    }

    @discardableResult
    func heightButton() -> YetLayout {
        self.height(YetLayoutConst.buttonHeight)
        return self
    }

    @discardableResult
    func widthLe(_ w: CGFloat) -> YetLayout {
        self.width.le(w).active()
        return self
    }

    @discardableResult
    func widthGe(_ w: CGFloat) -> YetLayout {
        self.width.ge(w).active()
        return self
    }

    @discardableResult
    func width(_ w: CGFloat) -> YetLayout {
        self.width.eq(w).active()
        return self
    }

    @discardableResult
    func size(_ sz: CGFloat) -> YetLayout {
        self.width(sz).height(sz)
    }

    @discardableResult
    func size(_ w: CGFloat, _ h: CGFloat) -> YetLayout {
        self.width(w).height(h)
    }

    @discardableResult
    func widthFit(_ c: CGFloat = 0) -> YetLayout {
        let sz = self.view.sizeThatFits(CGSize.zero)
        self.width(sz.width + c)
        return self
    }

    @discardableResult
    func heightFit(_ c: CGFloat = 0) -> YetLayout {
        let sz = self.view.sizeThatFits(CGSize.zero)
        self.height(sz.height + c)
        return self
    }

    @discardableResult
    func sizeFit() -> YetLayout {
        let sz = self.view.sizeThatFits(CGSize.zero)
        self.width(sz.width)
        self.height(sz.height)
        return self
    }

    @discardableResult
    func heightByScreen(_ c: CGFloat = 0) -> YetLayout {
        let sz = self.view.sizeThatFits(Size(width: UIScreen.width, height: 0))
        self.height(sz.height + c)
        return self
    }

}

public class YetLayoutConst {
    public static var buttonHeight: CGFloat = 42
    public static var editHeight: CGFloat = 42
    public static var textHeight: CGFloat = 30
}