//
//  UITextField+FKExtension.swift
//  FantasyKit
//
//  Created by Tony Chen on 7/15/20.
//  Copyright © 2020 Tony Chen. All rights reserved.
//

import Foundation
import UIKit

public extension UITextField {
    func selectAllText() {
        let range = textRange(from: beginningOfDocument, to: endOfDocument)
        selectedTextRange = range
    }
    
    func setSelectedRange(_ range: Range<Int>) {
        let start = position(from: beginningOfDocument, offset: range.lowerBound) ?? beginningOfDocument
        let end = position(from: beginningOfDocument, offset: range.upperBound) ?? endOfDocument
        selectedTextRange = textRange(from: start, to: end)
    }
}
