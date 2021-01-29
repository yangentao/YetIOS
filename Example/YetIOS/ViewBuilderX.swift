//
// Created by yangentao on 2021/1/29.
// Copyright (c) 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit


extension UIView {

    @discardableResult
    func apply(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}