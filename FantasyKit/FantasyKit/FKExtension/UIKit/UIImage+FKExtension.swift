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
    
    class func imageWithPDF(_ data: Any) -> UIImage? {
        return self.imageWithPDF(data, resize: false, size: CGSize.zero)
    }
    class func imageWithPDF(_ data: Any, size: CGSize) -> UIImage? {
        return self.imageWithPDF(data, resize: true, size: size)
    }
    class func imageWithPDF(_ data: Any, resize: Bool, size: CGSize) -> UIImage? {
        var pdfValue: CGPDFDocument? = nil
        if let data = data as? Data {
            if let provider = CGDataProvider(data: data as CFData) {
                pdfValue = CGPDFDocument(provider)
            }
        } else if let path = data as? String {
            pdfValue = CGPDFDocument(URL(fileURLWithPath: path) as CFURL)
        }
        guard let pdf = pdfValue else {return nil}
        guard let page = pdf.page(at: 1) else {return nil}
        let pdfRect = page.getBoxRect(CGPDFBox.cropBox)
        let pdfSize = resize ? size : pdfRect.size
        let scale = UIScreen.main.scale
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let ctx = CGContext(data: nil, width: Int(pdfSize.width * scale), height: Int(pdfSize.height * scale), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageByteOrderInfo.orderDefault.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue) else {return nil}
        
        ctx.scaleBy(x: scale, y: scale)
        ctx.translateBy(x: -pdfRect.origin.x, y: -pdfRect.origin.y)
        ctx.drawPDFPage(page)
        
        if let image = ctx.makeImage() {
            return UIImage(cgImage: image, scale: scale, orientation: UIImage.Orientation.up)
        }
        return nil
    }
    
    class func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        if let cxt = UIGraphicsGetCurrentContext() {
            cxt.setFillColor(color.cgColor)
            cxt.fill(rect)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return img
        }
        return nil
    }
    
    class func image(size: CGSize, drawBlock:(CGContext)->Void) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        if let ctx = UIGraphicsGetCurrentContext() {
            drawBlock(ctx)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
    
    var hasAlphaChannel: Bool {
        if let cgImage = self.cgImage {
            let alpha = cgImage.alphaInfo.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
            return alpha == CGImageAlphaInfo.first.rawValue ||
                    alpha == CGImageAlphaInfo.last.rawValue ||
                    alpha == CGImageAlphaInfo.premultipliedFirst.rawValue ||
                    alpha == CGImageAlphaInfo.premultipliedLast.rawValue
        } else {
            return false
        }
    }
//    func draw(_ rect: CGRect, contentMode: UIView.ContentMode, clips: Bool) {
//        let drawRect = cgrectfitwith
//    }
//    func resize(_ size: CGSize) -> UIImage {
//        
//    }
//    func resize(_ size: CGSize, contentMode)
}
