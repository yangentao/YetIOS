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
    lazy var label: UILabel = NamedView(self, "hello")

    override func viewDidLoad() {
        super.viewDidLoad()


        self.view.layoutConstraint {
            UILabel(frame: .zero).apply { lb in
                lb.constraints {
                    $0.centerParent().size(200, 100)
                }
                lb.nameID("hello")
                lb.alignCenter()
                lb.backgroundColor = .cyan
                lb.text = "Hello"
            }
            UILabel(frame: .zero).apply { lb in
                lb.constraints {
                    $0.size(200, 100).below("hello").centerXParent()
                }
                lb.alignCenter()
                lb.backgroundColor = .green
                lb.text = "Entao"
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