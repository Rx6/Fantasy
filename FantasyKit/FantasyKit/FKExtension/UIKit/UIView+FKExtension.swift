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
            return snap
        } else {
            return nil
        }
    }
    
    var snapshotPDF: Data? {
        var bounds = self.bounds
        let data = Data()
        if let consumer = CGDataConsumer(data: data as! CFMutableData), let context = CGContext(consumer: consumer, mediaBox: &bounds, nil) {
            context.beginPDFPage(nil)
            context.translateBy(x: 0, y: bounds.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            self.layer.render(in: context)
            context.endPDFPage()
            context.closePDF()
            return data
        }
        return nil
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
    
    func convert(point: CGPoint, toView: UIView?) -> CGPoint {
        guard let view = toView else {
            if let window = self as? UIWindow {
                return window.convert(point, to: nil)
            } else {
                return self.convert(point, to: nil)
            }
        }
        if let from = view is UIWindow ? (view as! UIWindow) : view.window, let to = self is UIWindow ? (self as! UIWindow) : self.window, from != to {
            var result = self.convert(point, to: from)
            result = to.convert(result, from: from)
            return view.convert(result, from: to)
        } else {
            return self.convert(point, to: view)
        }
    }
    func convert(point: CGPoint, fromView: UIView?) -> CGPoint {
        guard let view = fromView else {
            if let window = self as? UIWindow {
                return window.convert(point, from: nil)
            } else {
                return self.convert(point, from: nil)
            }
        }
        if let from = view is UIWindow ? (view as! UIWindow) : view.window, let to = self is UIWindow ? (self as! UIWindow) : self.window, from != to {
            var result = from.convert(point, from: view)
            result = to.convert(result, from: from)
            return self.convert(result, from: to)
        } else {
            return self.convert(point, from: view)
        }
    }
    func convert(rect: CGRect, toView: UIView?) -> CGRect {
        guard let view = toView else {
            if let window = self as? UIWindow {
                return window.convert(rect, to: nil)
            } else {
                return self.convert(rect, to: nil)
            }
        }
        if let from = view is UIWindow ? (view as! UIWindow) : view.window, let to = self is UIWindow ? (self as! UIWindow) : self.window, from != to {
            var result = self.convert(rect, to: from)
            result = to.convert(result, from: from)
            return view.convert(result, from: to)
        } else {
            return self.convert(rect, to: view)
        }
    }
    func convert(rect: CGRect, fromView: UIView?) -> CGRect {
        guard let view = fromView else {
            if let window = self as? UIWindow {
                return window.convert(rect, from: nil)
            } else {
                return self.convert(rect, from: nil)
            }
        }
        if let from = view is UIWindow ? (view as! UIWindow) : view.window, let to = self is UIWindow ? (self as! UIWindow) : self.window, from != to {
            var result = from.convert(rect, from: view)
            result = to.convert(result, from: from)
            return self.convert(result, from: to)
        } else {
            return self.convert(rect, from: view)
        }
    }
    
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
