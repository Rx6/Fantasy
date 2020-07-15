//
//  UIBarButtonItem+Extension.swift
//  TCExtension
//
//  Created by Tony on 2020/7/10.
//  Copyright © 2020 East. All rights reserved.
//

import Foundation
import UIKit

public extension UIBarButtonItem {
    func actionBlock(_ block: @escaping (Any)->Void) {
        let target = TCUIBarButtonItemBlockTarget(block)
        objc_setAssociatedObject(self, &AssociatedKeys.actionBlock, target, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.target = target
        self.action = #selector(TCUIBarButtonItemBlockTarget.invoke(_:))
    }
    
    
    private struct AssociatedKeys {
        static var actionBlock = "actionBlock"
    }
    
    private class TCUIBarButtonItemBlockTarget: NSObject {
        
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
