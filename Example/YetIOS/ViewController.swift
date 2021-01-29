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
        let ls: [Person] = buildTypedChildren(block)
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
        Person("Entao")
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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testChildren()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

