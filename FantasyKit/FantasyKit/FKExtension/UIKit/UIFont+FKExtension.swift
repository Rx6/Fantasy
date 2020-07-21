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
    
    class func font(ctFont: CTFont?) -> UIFont? {
        if let ctFont = ctFont {
            let name = CTFontCopyPostScriptName(ctFont)
            let size = CTFontGetSize(ctFont)
            return self.init(name: String(name), size: size)
        }
        return nil
    }
    
    class func font(cgFont: CGFont, size: CGFloat) -> UIFont? {
        if let name = cgFont.postScriptName {
            return self.init(name: String(name), size: size)
        }
        return nil
    }
    class func loadFont(path: String) -> Bool {
        let url = URL(fileURLWithPath: path)
        return CTFontManagerRegisterFontsForURL(url as CFURL, .none, nil)
    }
    class func unloadFont(path: String) -> Bool {
        let url = URL(fileURLWithPath: path)
        return CTFontManagerUnregisterFontsForURL(url as CFURL, .none, nil)
    }
    class func loadFont(data: Data) -> UIFont? {
        if let provider = CGDataProvider(data: data as CFData), let cgFont = CGFont(provider) {
            if CTFontManagerRegisterGraphicsFont(cgFont, nil) {
                if let fontName = cgFont.postScriptName {
                    return self.init(name: String(fontName), size: self.systemFontSize)
                }
            }
        }
        return nil
    }
    class func unloadFont(font: UIFont) -> Bool {
        if let fontRef = font.cgFont {
            return CTFontManagerUnregisterGraphicsFont(fontRef, nil)
        }
        return false
    }
    
    var ctFont: CTFont {
        CTFontCreateWithName(self.fontName as CFString, self.pointSize, nil)
    }
    var cgFont: CGFont? {
        CGFont(self.fontName as CFString)
    }
    
}
