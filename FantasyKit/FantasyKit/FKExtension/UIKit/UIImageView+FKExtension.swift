//
//  UIImageView+FKExtension.swift
//  FantasyKit
//
//  Created by Tony on 2020/7/21.
//  Copyright © 2020 Tony Chen. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

public extension UIImageView {
    convenience init(imageName: String? = nil, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        self.init()
        contentMode = mode
        if let named = imageName {
            image = UIImage(named: named)
        }
    }
    
    func setImage(_ name: String?) {
        setImage(name: name)
    }
    func setImage(name: String?, placeholder: UIImage? = nil, block: CompletionHandler? = nil) {
        if let name = name {
            if let url = URL(string: name), url.scheme != nil, url.host != nil, url.path.count > 0 {
                // name is URL, use Kingfisher
                kf.setImage(with: url, placeholder: placeholder, completionHandler: block)
            } else {
                if let contextImage = UIImage(named: name) {
                    image = contextImage
                } else if let placeholder = placeholder {
                    image = placeholder
                }
                block?(image, nil, CacheType.none, nil)
            }
        } else {
            if let placeholder = placeholder {
                image = placeholder
            }
            block?(image, nil, CacheType.none, nil)
        }
    }
}
