//
// Created by yangentao on 2021/1/29.
//

import Foundation



public class AnyGroup {
    private var items = [Any]()

    init(_ items: [Any]) {
        self.items = items
    }

    var flatItems: [Any] {
        var ls = [Any]()
        for a in items {
            if let g = a as? AnyGroup {
                ls.append(contentsOf: g.flatItems)
            } else {
                ls.append(a)
            }
        }
        return ls
    }


}


@_functionBuilder
public struct AnyBuilder {

    public static func buildBlock(_ cs: Any...) -> AnyGroup {
        AnyGroup(cs)
    }

    public static func buildIf(_ content: Any?) -> Any {
        content ?? AnyGroup([])
    }

    public static func buildEither(first: Any) -> Any {
        first
    }

    public static func buildEither(second: Any) -> Any {
        second
    }
}


public func buildAnyChildren(@AnyBuilder _ block: () -> AnyGroup) -> [Any] {
    let c = block()
    return c.flatItems
}

public func buildTypedChildren<T: Any>(@AnyBuilder _ block: () -> AnyGroup) -> [T] {
    let c = block()
    return c.flatItems.map {
        $0 as! T
    }
}