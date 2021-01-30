//
//  ViewController.swift
//  YetIOS
//
//  Created by yangentao on 01/02/2021.
//  Copyright (c) 2021 yangentao. All rights reserved.
//

import UIKit

import YetIOS


class Person: CustomStringConvertible {
    var name: String = ""
    var children: [Person] = []

    init(_ name: String = "") {
        self.name = name
    }

    var description: String {
        "Person{\(name), \(children)}"
    }
}


extension Person {

    func buildChild(@AnyBuilder _ block: () -> AnyGroup) -> Person {
        let ls: [Person] = buildItemsTyped(block)
        for p in ls {
            self.children.append(p)
        }
        return self
    }

    @discardableResult
    public func apply(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}


func testChildren() {
    var n = 0
    let p = Person("Song").buildChild {
        let entao = Person("Entao")
        entao
        testVoid()
        if n == 0 {
            Person("Dou")
        }
        Person("Chen").buildChild {
            Person("Wen")
        }
        Person("Hua").buildChild {
        }
    }
    print(p)
}

func testVoid() {
    println("TestVoid")
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testChildren()

//        let lb = UILabel(frame: .zero)
//        self.view.addSubview(lb)

        self.view.layoutConstraint {
            UILabel(frame: .zero).constraints {
                $0.centerParent().size(200, 100)
            }.apply { lb in
                lb.layout.centerParent().size(300, 200)
                lb.alignCenter()
                lb.backgroundColor = .cyan
                lb.text = "Hello"
            }
        }

//        self.view.apply { v in
//            v.label { lb in
//                lb.layout.centerParent().size(300, 200)
//                lb.alignCenter()
//                lb.backgroundColor = .cyan
//                lb.text = "Hello"
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIView {

    @discardableResult
    func label(block: (UILabel) -> Void) -> UILabel {
        let lb = UILabel(frame: .zero)
        self.addSubview(lb)
        block(lb)
        return lb
    }
}

