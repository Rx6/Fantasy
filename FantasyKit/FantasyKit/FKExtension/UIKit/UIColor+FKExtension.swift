//
//  UIColor+TCExtension.swift
//  TCExtension
//
//  Created by Tony on 2020/7/10.
//  Copyright © 2020 East. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    convenience init(withHex hex: String) {
        var hex = hex
        hex = hex.uppercased()
        var prefix = "#"

        if hex.hasPrefix(prefix) {
            hex = hex.replacingOccurrences(of: prefix, with: "").uppercased()
        }

        prefix = "0X"
        if hex.hasPrefix(prefix) {
            hex = hex.replacingOccurrences(of: prefix, with: "").uppercased()
        }

        var alpha: CGFloat = 0
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        
        switch hex.count {
            case 3 /* #RGB */:
                alpha = 1.0
                red = UIColor.colorComponent(from: hex, start: 0, length: 1)
                green = UIColor.colorComponent(from: hex, start: 1, length: 1)
                blue = UIColor.colorComponent(from: hex, start: 2, length: 1)
            case 4 /* #ARGB */:
                alpha = UIColor.colorComponent(from: hex, start: 0, length: 1)
                red = UIColor.colorComponent(from: hex, start: 1, length: 1)
                green = UIColor.colorComponent(from: hex, start: 2, length: 1)
                blue = UIColor.colorComponent(from: hex, start: 3, length: 1)
            case 6 /* #RRGGBB */:
                alpha = 1.0
                red = UIColor.colorComponent(from: hex, start: 0, length: 2)
                green = UIColor.colorComponent(from: hex, start: 2, length: 2)
                blue = UIColor.colorComponent(from: hex, start: 4, length: 2)
            case 8 /* #AARRGGBB */:
                alpha = UIColor.colorComponent(from: hex, start: 0, length: 2)
                red = UIColor.colorComponent(from: hex, start: 2, length: 2)
                green = UIColor.colorComponent(from: hex, start: 4, length: 2)
                blue = UIColor.colorComponent(from: hex, start: 6, length: 2)
            default:
                NSException.raise(NSExceptionName(rawValue: "Invalid color value"), format: "Color value \(hex) is invalid.  It should be a hex value of the form RBG, ARGB, RRGGBB, AARRGGBB and optional prefix #,0x,0X", arguments: getVaList(["nil"]))
                break
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    class func colorComponent(from string: String, start: Int, length: Int) -> CGFloat {
        let substring = (string as NSString?)?.substring(with: NSRange(location: start, length: length))
        let fullHex = length == 2 ? substring : "\(substring ?? "")\(substring ?? "")"
        let scanner = Scanner.init(string: fullHex ?? "")
        var hexComponent: UInt64 = 100
        guard scanner.scanHexInt64(&hexComponent) else {
            return 0
        }

        return CGFloat(hexComponent) / 255.0
    }
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }

    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
}
