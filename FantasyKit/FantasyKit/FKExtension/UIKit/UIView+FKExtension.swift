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
}
