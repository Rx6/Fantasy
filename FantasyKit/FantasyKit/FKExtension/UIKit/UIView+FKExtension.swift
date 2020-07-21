//
//  UIView+FKExtension.swift
//  FantasyKit
//
//  Created by Tony Chen on 7/15/20.
//  Copyright © 2020 Tony Chen. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    var snapshotImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let snap = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return snap;
        } else {
            return nil
        }
    }
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
    var viewController: UIViewController? {
        var view = self
        while let responder = view.next {
            if let vc = responder as? UIViewController {
                return vc
            }
            if let vi = view.superview {
                view = vi
            } else {
                break
            }
        }
        return nil
    }
    
    var visibleAlpha: CGFloat {
        if self is UIWindow {
            return isHidden ? 0 : alpha
        }
        guard window != nil else {return 0}
        var alpha: CGFloat = 1
        var v: UIView? = self
        while let vi = v {
            if vi.isHidden {
                alpha = 0
            } else {
                alpha *= vi.alpha
                v = vi.superview
            }
        }
        return alpha
    }
    
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    
//    func convert(_ point: CGPoint, toView: UIView?) -> CGPoint {
//        if let view = toView {
//            let from: UIWindow?
//            let to: UIWindow?
//            if let window = self as? UIWindow {
//                from = window
//            } else {
//                from = self.window
//            }
//        } else {
//            if let windown = self as? UIWindow {
//                return windown.convert(point, to: nil)
//            } else {
//                return self.convert(point, to: nil)
//            }
//        }
//    }
    
    func setLayerShadow(_ color: UIColor, offset: CGSize, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func removeAllSubviews() {
        while self.subviews.count > 0 {
            subviews.last?.removeFromSuperview()
        }
    }
}
