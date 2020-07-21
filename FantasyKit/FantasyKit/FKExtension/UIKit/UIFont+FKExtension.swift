//
//  UIFont+TCExtension.swift
//  TCExtension
//
//  Created by Tony on 2020/7/10.
//  Copyright © 2020 East. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {
    class func font(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    class func font(_ size: CGFloat, weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    class func font(_ size: CGFloat, fontName: String) -> UIFont {
        return UIFont.init(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    var isBold: Bool {
        if self.responds(to: #selector(getter: self.fontDescriptor)) {
            return (self.fontDescriptor.symbolicTraits & UIFontDescriptor.SymbolicTraits.traitBold) > 0
        } else {
            return false
        }
    }
}
