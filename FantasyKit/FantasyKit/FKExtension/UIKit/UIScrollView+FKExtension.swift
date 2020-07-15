//
//  UIScrollView+TCExtension.swift
//  TCExtension
//
//  Created by Tony on 2020/7/10.
//  Copyright © 2020 East. All rights reserved.
//

import Foundation
import UIKit

public extension UIScrollView {
    func scrollToTop(_ animated: Bool = true) {
        var off = self.contentOffset
        off.y = 0 - self.contentInset.top
        self.setContentOffset(off, animated: animated)
    }
    func scrollToBottom(_ animated: Bool = true) {
        var off = self.contentOffset
        off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom
        self.setContentOffset(off, animated: animated)
    }
    func scrollToLeft(_ animated: Bool = true) {
        var off = self.contentOffset
        off.x = 0 - self.contentInset.left
        self.setContentOffset(off, animated: animated)
    }
    func scrollToRight(_ animated: Bool = true) {
        var off = self.contentOffset
        off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right
        self.setContentOffset(off, animated: animated)
    }
}
