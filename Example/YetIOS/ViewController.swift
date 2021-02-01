//
//  ViewController.swift
//  YetIOS
//
//  Created by yangentao on 01/02/2021.
//  Copyright (c) 2021 yangentao. All rights reserved.
//

import UIKit
import YetIOS


class ViewController: UIViewController {
    lazy var label: UILabel = NamedView(self, "a")

    override func viewDidLoad() {
        super.viewDidLoad()


        self.view.layoutConstraint {
            VStack(dist: .fillEqually, align: .fill).space(0).arrange {
                MLabel.apply { lb in
                    lb.named("a")
                    lb.alignCenter()
                    lb.backgroundColor = Colors.background
                    lb.textColor = Colors.label
                    lb.font = Font.sys(UIFont.labelFontSize)
                    lb.text = "AAAAAAA"
                }
                MLabel.apply { lb in
                    lb.alignCenter()
                    lb.backgroundColor = Colors.backgroundSecondary
                    lb.textColor = Colors.labelSecondary
                    lb.font = Font.sys(UIFont.labelFontSize)
                    lb.text = "BBBB"
                }
                MLabel.apply { lb in
                    lb.alignCenter()
                    lb.backgroundColor = Colors.backgroundTertiary
                    lb.textColor = Colors.labelTertiary
                    lb.font = Font.sys(UIFont.labelFontSize)
                    lb.text = "CCC"
                }
            }.constraints {
                $0.centerParent().widthParent(-40).heightParent(-40)
            }
        }
        log("LabelText: ", label.text)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//@propertyWrapper
//public struct View<T> {
//    let key: String
//
//    public init(_ key: String) {
//        self.key = key
//    }
//
//    public var wrappedValue: T {
//        get {
//            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: key)
//        }
//    }
//}
