//
//  UIImage+TCExtension.swift
//  TCExtension
//
//  Created by Tony on 2020/7/10.
//  Copyright © 2020 East. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    static func image(withColor color: UIColor) -> UIImage! {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let cxt = UIGraphicsGetCurrentContext()
        
        cxt?.setFillColor(color.cgColor)
        cxt?.fill(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage.init()
    }
}
