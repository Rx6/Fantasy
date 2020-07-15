//
//  UIControl+TCExtension.swift
//  TCExtension
//
//  Created by Tony on 2020/7/10.
//  Copyright © 2020 East. All rights reserved.
//

import Foundation
import UIKit

public extension UIControl {
    func removeAllTargets() {
        self.allTargets.forEach { (target) in
            self.removeTarget(target, action: nil, for: .allEvents)
        }
        self._tc_UIControlBlockTargets(nil)
    }
    
    func add(_ target: Any, action: Selector, forEvent event: UIControl.Event) {
        let targets = self.allTargets
        for currentTarget in targets {
            if let actions = self.actions(forTarget: currentTarget, forControlEvent: event) {
                for currentAction in actions {
                    self.removeTarget(currentTarget, action: Selector(currentAction), for: event)
                }
            }
        }
        self.addTarget(target, action: action, for: event)
    }
    
    func add(_ event: UIControl.Event, block: @escaping ((Any)->Void)) {
        let target = TCUIControlBlockTarget(block, event: event)
        self.addTarget(target, action: #selector(TCUIControlBlockTarget.invoke(_:)), for: event)
        self._tc_UIControlBlockTargets([target])
    }
    
    func update(_ event: UIControl.Event, block: @escaping ((Any)->Void)) {
        self.remove(event)
        self.add(event, block: block)
    }
    
    func remove(_ event: UIControl.Event) {
        var targets = self._tc_allUIControlBlockTargets()
        for (index, target) in targets.enumerated() {
            if target.events == event {
                self.removeTarget(target, action: #selector(TCUIControlBlockTarget.invoke(_:)), for: event)
                targets.remove(at: index)
            }
        }
        self._tc_UIControlBlockTargets(nil)
        self._tc_UIControlBlockTargets(targets)
    }
    
    private func _tc_allUIControlBlockTargets() -> [TCUIControlBlockTarget] {
        return objc_getAssociatedObject(self, &AssociatedKeys.actionBlock) as? [TCUIControlBlockTarget] ?? []
    }
    
    private func _tc_UIControlBlockTargets(_ newTargets: [TCUIControlBlockTarget]?) {
        if let newTargets = newTargets {
            var targets = _tc_allUIControlBlockTargets()
            targets.append(contentsOf: newTargets)
            objc_setAssociatedObject(self, &AssociatedKeys.actionBlock, targets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        } else {
            objc_setAssociatedObject(self, &AssociatedKeys.actionBlock, [], .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private struct AssociatedKeys {
        static var actionBlock = "actionBlock"
    }
    
    private class TCUIControlBlockTarget: NSObject {
        
        init(_ block: @escaping ((Any)->Void), event: UIControl.Event) {
            super.init()
            self.actionBlock = block
            self.events = event
        }
        
        lazy var actionBlock: ((Any)->Void)? = nil
        lazy var events: UIControl.Event = .allEvents
        
        @objc public func invoke(_ sender: Any) {
            self.actionBlock?(sender)
        }
    }
}
