//
// Created by yangentao on 2021/2/1.
//

import Foundation
import UIKit

public extension UIView {

    func linearVertical(@AnyBuilder _ block: AnyBuildBlock) {
        let b = block()
        let viewList: [UIView] = b.itemsTyped()
        let ls = viewList.filter {
            $0 !== self && $0.linearParam != nil
        }
        for childView in ls {
            addSubview(childView)
        }
        installChildrenLinearVertical(ls)
    }

    func installChildrenLinearVertical(_ viewList: [UIView]) {

    }
}