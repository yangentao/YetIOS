//
// Created by entaoyang@163.com on 2017/10/11.
// Copyright (c) 2017 yet.net. All rights reserved.
//

import Foundation
import UIKit


@available(iOS 13.0, *)
public func makeColor(_ normalColor: UIColor, darkColor: UIColor) -> UIColor {
    return UIColor { (trait) -> UIColor in
        if trait.userInterfaceStyle == .dark {
            return darkColor
        } else {
            return normalColor
        }
    }
}

public class Colors {
    public static var seprator: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.separator
        }
        return Color.whiteF(0.85)
    }()
    public static var background: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        }
        return Color.white
    }()
    public static var backgroundSecondary: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemBackground
        }
        return Color.whiteF(0.9)
    }()
    public static var backgroundTertiary: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.tertiarySystemBackground
        }
        return Color.whiteF(0.8)
    }()


    public static var label: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.label
        }
        return Color.whiteF(0.2)
    }()

    public static var labelSecondary: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.secondaryLabel
        }
        return Color.whiteF(0.3)
    }()

    public static var labelTertiary: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.tertiaryLabel
        }
        return Color.whiteF(0.4)
    }()

    public static var labelQuaternary: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.quaternaryLabel
        }
        return Color.whiteF(0.5)
    }()

}

public class ControlSize {
    public static var buttonHeight: CGFloat = 42
    public static var editHeight: CGFloat = 42
    public static var textHeight: CGFloat = 30
}

public class Dim {
    public static var sep: CGFloat = 8
    public static var sep2: CGFloat = 16
    public static var edge0: CGFloat = 12
    public static var edge1: CGFloat = 16
    public static var edge: CGFloat = 16
    public static var edge2: CGFloat = 22
    public static var edgeInput: CGFloat = 32
    public static var iconSize0: CGFloat = 25
    public static var iconSize: CGFloat = 32
    public static var iconSize2: CGFloat = 72
    public static var itemHeightNormal: CGFloat = 52
    public static var itemHeightLarge: CGFloat = 90
}

public class Theme {
    public static var imagePostfix = "-light"
    public static var themeColor: UIColor = 0x4FB29D.rgb
    public static var fadeColor: UIColor = 0xff8800.rgb
    public static var dangerColor: UIColor = 0xd81e06.rgb
    public static var safeColor: UIColor = 0x36ab60.rgb
    public static var grayBackColor: UIColor = Color.whiteF(0.85)

    public static var sepratorColor: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.separator
        }
        return Color.whiteF(0.85)
    }()
    public static var background: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        }
        return Color.white
    }()


    public class Text {
//        public static var primaryColor: UIColor = 0x4A4A4A.rgb  //UIColor.darkText //
        public static var primaryColor: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.label
            }
            return 0x4A4A4A.rgb
        }()

        public static var minorColor: UIColor = Color.whiteF(0.50)
        public static var disabledColor: UIColor = Color.rgb(135, 154, 168)

        public static var primaryFont: UIFont = Font.sys(16)
        public static var minorFont: UIFont = Font.sys(14)
        public static var height: CGFloat = 25
        public static var height2: CGFloat = 30
        public static var heightMinor: CGFloat = 20


    }

    public class Edit {
        public static var heightMini: CGFloat = 25
        public static var heightSmall: CGFloat = 32
        public static var height: CGFloat = 42
        public static var corner: CGFloat = 6
        public static var borderNormal: UIColor = Color.rgb(200, 200, 200)
        public static var borderActive: UIColor = Theme.themeColor //Colors.rgb(74, 144, 226)
        public static var borderError: UIColor = Theme.dangerColor
    }

    public class Button {
        public static var textColor: UIColor = Theme.Text.primaryColor
        public static var textColorFade: UIColor = Theme.fadeColor
        public static var backColor: UIColor = UIColor.white
        public static var borderColor: UIColor = Color.whiteF(0.5)
        public static var disabledColor: UIColor = 0xE9EDF1.rgb
        public static var roundCorner: CGFloat = 5
        public static var height: CGFloat = 36
        public static var heightLarge: CGFloat = 42

    }

    public class TabBar {
        public static var lightColor: UIColor? = Theme.themeColor
        public static var grayColor: UIColor? = 0x707070.rgb
        public static var backgroundColor: UIColor? = 0xf8f8f8.rgb
        public static var imageSize: CGFloat = 30
    }

    public class TitleBar {
        public static var textColor: UIColor = UIColor.white
        public static var backgroundColor: UIColor = Theme.themeColor

        public static var imageSize: CGFloat = 30
    }

}


