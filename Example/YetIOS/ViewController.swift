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

            MLabel.apply { lb in
                lb.constraints {
                    $0.centerParent().size(200, 100)
                }
                lb.named("a")
                lb.alignCenter()
                lb.backgroundColor = Colors.backgroundSecondary
                lb.textColor = Colors.labelSecondary
                lb.text = "AAAAAAA"
                lb.font = Font.sys( UIFont.labelFontSize)

            }
            MLabel.apply { lb in
                lb.constraints {
                    $0.size(200, 100).above("a").centerXParent()
                }
                lb.named("b")
                lb.alignCenter()
                lb.backgroundColor = Colors.background
                lb.textColor = Colors.label
                lb.text = "BBBBBBB"
                lb.font = Font.sys( UIFont.labelFontSize + 2)
            }
            MLabel.apply { lb in
                lb.constraints {
                    $0.size(200, 100).below("a").centerXParent()
                }
                lb.named("c")
                lb.alignCenter()
                lb.backgroundColor = Colors.backgroundTertiary
                lb.textColor = Colors.labelTertiary
                lb.text = "CCCCCC"
                lb.font = Font.sys( UIFont.labelFontSize - 2 )
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
