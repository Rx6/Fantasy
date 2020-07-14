//
//  CALayer+FKExtension.swift
//  FantasyKit
//
//  Created by Tony Chen on 7/14/20.
//  Copyright © 2020 Tony Chen. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

public extension CALayer {
    var snapshotImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        if let context = UIGraphicsGetCurrentContext() {
            self.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        } else {
            return nil
        }
    }
    
//    var snapshotPDF: Data? {
//        let bounds = self.bounds
//        var data = Data()
//        let consumer = CGDataConsumer(data: data as! CFMutableData)!
//        let context = CGContext(consumer: consumer, mediaBox: &self.bounds, nil)
//        CFRelease(consumer)
//
//    }
    
    func layerShadow(_ color: UIColor, offset: CGSize, radius: CGFloat) {
        self.shadowColor = color.cgColor
        self.shadowOffset = offset
        self.shadowRadius = radius
        self.shadowOpacity = 1
        self.shouldRasterize = true
        self.rasterizationScale = UIScreen.main.scale
    }
    
    func removeAllSublayers() {
        while self.sublayers?.count ?? 0 > 0 {
            self.sublayers?.last?.removeFromSuperlayer()
        }
    }
    
    func addFadeAnimation(_ duration: TimeInterval, curve: UIView.AnimationCurve) {
        
    }
    
    func removePreviousFadeAnimation() {
        
    }
}

public extension CALayer {
    var left: CGFloat {
        get {
            return self.frame.minX
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var top: CGFloat {
        get {
            self.frame.minY
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var right: CGFloat {
        get {
            self.frame.maxX
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.width
            self.frame = frame
        }
    }
    var bottom: CGFloat {
        get {
            self.frame.maxY
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.height
            self.frame = frame
        }
    }
    var width: CGFloat {
        get {
            self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    var height: CGFloat {
        get {
            self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    var center: CGPoint {
        get {
            CGPoint(x: self.frame.origin.x + self.width * 0.5, y: self.frame.origin.y + self.height * 0.5)
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue.x - frame.size.width * 0.5
            frame.origin.y = newValue.y - frame.size.height * 0.5
            self.frame = frame
        }
    }
    var centerX: CGFloat {
        get {
            self.left + self.width * 0.5
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.width * 0.5
            self.frame = frame
        }
    }
    var centerY: CGFloat {
        get {
            self.top + self.height * 0.5
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.height * 0.5
            self.frame = frame
        }
    }
    var origin: CGPoint {
        get {
            self.frame.origin
        }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    var frameSize: CGSize {
        get {
            self.frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    var transfomRotation: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.rotation") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.rotation")
        }
    }
    
    
    var transformRotationX: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.rotation.x") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.rotation.x")
        }
    }
    var transfomRotationY: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.rotation.y") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.rotation.y")
        }
    }
    var transfomRotationZ: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.rotation.z") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.rotation.z")
        }
    }
    var transformScaleX: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.scale.x") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.scale.x")
        }
    }
    var transformScaleY: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.scale.y") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.scale.y")
        }
    }
    var transformScaleZ: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.scale.z") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.scale.z")
        }
    }
    var transformScale: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.scale") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.scale")
        }
    }
    
    var transformTranslation: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.translation") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.translation")
        }
    }
    var transformTranslationX: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.translation.x") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.translation.x")
        }
    }
    var transformTranslationY: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.translation.y") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.translation.y")
        }
    }
    var transformTranslationZ: CGFloat {
        get {
            if let number = self.value(forKeyPath: "transform.translation.z") as? NSNumber {
                return CGFloat(number.doubleValue)
            } else {
                return 0
            }
        }
        set {
            self.setValue(newValue, forKeyPath: "transform.translation.z")
        }
    }
    var transformDepth: CGFloat {
        get {
            self.transform.m34
        }
        set {
            var d = self.transform
            d.m34 = newValue
            self.transform = d
        }
    }
//    var contentMode: UIView.ContentMode {
//        get {
//            
//        }
//        set {
//            
//        }
//    }
}
