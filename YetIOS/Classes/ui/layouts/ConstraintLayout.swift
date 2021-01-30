//
// Created by yangentao on 2021/1/30.
//

import Foundation
import UIKit


//NSLayoutConstraint(item: self.view, attribute: attr, relatedBy: rel, toItem: view2, attribute: attr2, multiplier: multi, constant: constant)

private var _constraint_param_list_key = "_constraint_param_list_"


public func testView() {
    let view = UIView(frame: .zero)
    view.layoutConstraint {
        UILabel(frame: .zero).buildConstraints {
            ViewLeft.eq(100)
            ViewRight.eqParent
            ViewTop.eq("nameView", .top).multi(2).constant(10)
        }
    }

}


public extension UIView {

    fileprivate var _constraintItemArray: [ConstraintItem] {
        get {
            if let a = self.getAttr(_constraint_param_list_key) as? [ConstraintItem] {
                return a
            }
            let ls = [ConstraintItem]()
            setAttr(_constraint_param_list_key, ls)
            return ls
        }
        set {
            setAttr(_constraint_param_list_key, newValue)
        }
    }

    func buildConstraints(@AnyBuilder _ block: AnyBuildBlock) -> Self {
        let ls: [ConstraintItem] = block().itemsTyped()
        self._constraintItemArray = ls
        return self
    }

}


extension UIView {
    public func layoutConstraint(@AnyBuilder _ block: AnyBuildBlock) {
        let b = block()
        let viewList: [UIView] = b.itemsTyped()
        for childView in viewList {
            let cList = childView._constraintItemArray
            if !cList.isEmpty {
                childView.translatesAutoresizingMaskIntoConstraints = false
            }
            for c in cList {
                c.item = childView
                var toItemView: UIView? = nil
                if c.toItemView != nil {
                    toItemView = c.toItemView
                } else if let viewName = c.toItemName {
                    if viewName == self.name || viewName == _parent_view_name_ {
                        toItemView = self
                    } else if let toV = viewList.first { $0.name == viewName } {
                        toItemView = toV
                    } else {
                        fatalError("UIView.constraintLayout, No view name found: \(viewName)")
                    }
                }

                let cp = NSLayoutConstraint(item: c.item, attribute: c.attr, relatedBy: c.relation, toItem: toItemView, attribute: c.attr2, multiplier: c.multiplier, constant: c.constant)
                cp.priority = c.priority
                cp.identifier = c.ident
                childView.layoutConstraintList.items.append(cp)
            }
            for c in childView.layoutConstraintList.items {
                c.isActive = true
            }
        }
    }

}
