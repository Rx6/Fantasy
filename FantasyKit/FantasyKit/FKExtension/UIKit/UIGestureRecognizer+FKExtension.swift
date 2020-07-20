//
//  UIGestureRecognizer+TCExtension.swift
//  TCExtension
//
//  Created by Tony on 2020/7/10.
//  Copyright © 2020 East. All rights reserved.
//

import Foundation
import UIKit

public extension UIGestureRecognizer {
    
    convenience init(_ block: @escaping (Any)->Void) {
        self.init()
        add(block)
    }
    
    func add(_ block: @escaping (Any)->Void) {
        let target = TCUIGestureRecognizerBlockTarget(block)
        self.addTarget(target, action: #selector(TCUIGestureRecognizerBlockTarget.invoke(_:)))
        self._tc_UIGestureRecognizerBlockTargets([target])
    }
    
    func remove() {
        let targets = self._tc_allUIGestureRecognizerBlockTargets()
        if targets.count > 0 {
            targets.forEach { (item) in
                self.removeTarget(item, action: #selector(TCUIGestureRecognizerBlockTarget.invoke(_:)))
            }
        }
        _tc_UIGestureRecognizerBlockTargets(nil)
    }
    
    
    private func _tc_allUIGestureRecognizerBlockTargets() -> [TCUIGestureRecognizerBlockTarget] {
        return objc_getAssociatedObject(self, &AssociatedKeys.actionBlock) as? [TCUIGestureRecognizerBlockTarget] ?? []
    }
    
    private func _tc_UIGestureRecognizerBlockTargets(_ newTargets: [TCUIGestureRecognizerBlockTarget]?) {
        if let newTargets = newTargets {
            var targets = _tc_allUIGestureRecognizerBlockTargets()
            targets.append(contentsOf: newTargets)
            objc_setAssociatedObject(self, &AssociatedKeys.actionBlock, targets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        } else {
            objc_setAssociatedObject(self, &AssociatedKeys.actionBlock, [], .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private struct AssociatedKeys {
        static var actionBlock = "actionBlock"
    }
    
    private class TCUIGestureRecognizerBlockTarget: NSObject {
        
        init(_ block: @escaping ((Any)->Void)) {
            super.init()
            self.actionBlock = block
        }
        
        lazy var actionBlock: ((Any)->Void)? = nil
        
        @objc public func invoke(_ sender: Any) {
            self.actionBlock?(sender)
        }
    }
}
