//
//  UILabel_FKExtension.swift
//  FantasyKit
//
//  Created by Tony on 2020/7/21.
//  Copyright © 2020 Tony Chen. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    convenience init(font: UIFont, textColor: UIColor, numLines: Int = 1, align: NSTextAlignment = .left) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.textAlignment = align
        self.numberOfLines = numLines
    }
    convenience init(fontSize: CGFloat, fontWeight: UIFont.Weight = .regular, textColor: UIColor, numLines: Int = 1, align: NSTextAlignment = .left) {
        self.init()
        self.font = UIFont.font(fontSize, weight: fontWeight)
        self.textColor = textColor
        self.textAlignment = align
        self.numberOfLines = numLines
    }
}
