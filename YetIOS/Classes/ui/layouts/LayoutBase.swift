//
// Created by yangentao on 2021/1/30.
//

import Foundation
import UIKit


let _parent_view_name_ = "_parent_view_name_"

private var _constraint_list_key = "_conkey_"

public class NSLayoutConstraintList {
    var items = [NSLayoutConstraint]()
}

public extension UIView {
    var layoutConstraintList: NSLayoutConstraintList {
        if let ls = getAttr(_constraint_list_key) as? NSLayoutConstraintList {
            return ls
        }
        let c = NSLayoutConstraintList()
        setAttr(_constraint_list_key, c)
        return c
    }

    @discardableResult
    func updateConstraint(ident: String, constant: CGFloat) -> Self {
        if let a = layoutConstraintList.items.first { $0.identifier == ident } {
            a.constant = constant
            self.setNeedsUpdateConstraints()
            self.superview?.setNeedsUpdateConstraints()
        }
        return self
    }

    func removeAllConstraints() {
        for c in layoutConstraintList.items {
            c.isActive = false
        }
        layoutConstraintList.items = []
    }

    func removeConstraint(ident: String) {
        let c = layoutConstraintList.items.removeFirstIf { n in
            n.identifier == ident
        }
        c?.isActive = false
    }

    func layoutStretch(_ axis: NSLayoutConstraint.Axis) {
        self.setContentHuggingPriority(UILayoutPriority(rawValue: 240), for: axis)
    }

    func layoutKeepContent(_ axis: NSLayoutConstraint.Axis) {
        self.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 760), for: axis)
    }

}

public class ConstraintItem {
    unowned var item: UIView! // view
    var attr: NSLayoutConstraint.Attribute!
    var relation: NSLayoutConstraint.Relation!
    unowned var toItemView: UIView? = nil
    var toItemName: String? = nil
    var attr2: NSLayoutConstraint.Attribute!
    var multiplier: CGFloat = 1
    var constant: CGFloat = 0
    var ident: String? = nil
    var priority: UILayoutPriority = .required

    public func ident(_ id: String) -> ConstraintItem {
        ident = id
        return self
    }

    public func multi(_ m: CGFloat) -> ConstraintItem {
        multiplier = m
        return self
    }

    public func constant(_ c: CGFloat) -> ConstraintItem {
        constant = c
        return self
    }

    public func priority(_ p: UILayoutPriority) -> ConstraintItem {
        priority = p
        return self
    }

    public func priority(_ p: Float) -> ConstraintItem {
        priority = UILayoutPriority(rawValue: p)
        return self
    }
}

public class ConstraintItemRelation {
    let item = ConstraintItem()
}

public extension ConstraintItemRelation {

    func eq(_ value: CGFloat) -> ConstraintItem {
        item.relation = .equal
        item.constant = value
        return item
    }

    func eq(_ otherVieName: String) -> ConstraintItem {
        item.relation = .equal
        item.toItemName = otherVieName
        return item
    }

    func eq(_ otherVieName: String, _ attr2: NSLayoutConstraint.Attribute) -> ConstraintItem {
        item.relation = .equal
        item.toItemName = otherVieName
        item.attr2 = attr2
        return item
    }


    var eqParent: ConstraintItem {
        eq(_parent_view_name_)
    }

    func eqParent(_ attr2: NSLayoutConstraint.Attribute) -> ConstraintItem {
        eq(_parent_view_name_, attr2)
    }

    //--
    func le(_ value: CGFloat) -> ConstraintItem {
        item.relation = .lessThanOrEqual
        item.constant = value
        return item
    }

    func le(_ otherVieName: String) -> ConstraintItem {
        item.relation = .lessThanOrEqual
        item.toItemName = otherVieName
        return item
    }

    func le(_ otherVieName: String, _ attr2: NSLayoutConstraint.Attribute) -> ConstraintItem {
        item.relation = .lessThanOrEqual
        item.toItemName = otherVieName
        item.attr2 = attr2
        return item
    }


    var leParent: ConstraintItem {
        le(_parent_view_name_)
    }

    func leParent(_ attr2: NSLayoutConstraint.Attribute) -> ConstraintItem {
        le(_parent_view_name_, attr2)
    }

    //--

    func ge(_ value: CGFloat) -> ConstraintItem {
        item.relation = .greaterThanOrEqual
        item.constant = value
        return item
    }

    func ge(_ otherVieName: String) -> ConstraintItem {
        item.relation = .greaterThanOrEqual
        item.toItemName = otherVieName
        return item
    }

    func ge(_ otherVieName: String, _ attr2: NSLayoutConstraint.Attribute) -> ConstraintItem {
        item.relation = .greaterThanOrEqual
        item.toItemName = otherVieName
        item.attr2 = attr2
        return item
    }


    var geParent: ConstraintItem {
        ge(_parent_view_name_)
    }

    func geParent(_ attr2: NSLayoutConstraint.Attribute) -> ConstraintItem {
        ge(_parent_view_name_, attr2)
    }
}

public var ViewLeft: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .left
    a.item.attr2 = .left
    return a
}

public var ViewRight: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .right
    a.item.attr2 = .right
    return a
}

public var ViewTop: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .top
    a.item.attr2 = .top
    return a
}
public var ViewBottom: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .bottom
    a.item.attr2 = .bottom
    return a
}
public var ViewLeading: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .leading
    a.item.attr2 = .leading
    return a
}
public var ViewTrailing: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .trailing
    a.item.attr2 = .trailing
    return a
}
public var ViewWidth: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .width
    a.item.attr2 = .width
    return a
}
public var ViewHeight: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .height
    a.item.attr2 = .height
    return a
}

public var ViewCenterX: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .centerX
    a.item.attr2 = .centerX
    return a
}
public var ViewCenterY: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .centerY
    a.item.attr2 = .centerY
    return a
}
public var ViewLastBaseline: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .lastBaseline
    a.item.attr2 = .lastBaseline
    return a
}
public var ViewFirstBaseline: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .firstBaseline
    a.item.attr2 = .firstBaseline
    return a
}

public var ViewLeftMargin: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .leftMargin
    a.item.attr2 = .leftMargin
    return a
}

public var ViewRightMargin: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .rightMargin
    a.item.attr2 = .rightMargin
    return a
}
public var ViewTopMargin: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .topMargin
    a.item.attr2 = .topMargin
    return a
}

public var ViewBottomMargin: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .bottomMargin
    a.item.attr2 = .bottomMargin
    return a
}

public var ViewLeadingMargin: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .leadingMargin
    a.item.attr2 = .leadingMargin
    return a
}
public var ViewTrailingMargin: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .trailingMargin
    a.item.attr2 = .trailingMargin
    return a
}
public var ViewCenterXWithinMargins: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .centerXWithinMargins
    a.item.attr2 = .centerXWithinMargins
    return a
}

public var ViewCenterYWithinMargins: ConstraintItemRelation {
    let a = ConstraintItemRelation()
    a.item.attr = .centerYWithinMargins
    a.item.attr2 = .centerYWithinMargins
    return a
}


