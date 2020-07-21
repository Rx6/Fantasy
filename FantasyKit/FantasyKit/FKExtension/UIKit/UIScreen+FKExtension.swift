//
//  UIScreen+TCExtension.swift
//  TCExtension
//
//  Created by Tony on 2020/7/10.
//  Copyright © 2020 East. All rights reserved.
//

import Foundation
import UIKit

public extension UIScreen {
    var currentBounds: CGRect {
        return self.bounds(forOrientation: UIApplication.shared.statusBarOrientation)
    }
    
    func bounds(forOrientation: UIInterfaceOrientation?) -> CGRect {
        var bounds = self.bounds
        if forOrientation?.isLandscape ?? false {
            let buffer = bounds.width
            bounds.size.width = bounds.height
            bounds.size.height = buffer
        }
        return bounds
    }
    
    static var size: CGSize {
        return UIScreen.main.bounds.size
    }
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    static var isWidth320: Bool {
        (322 - width) > 0
    }
}
