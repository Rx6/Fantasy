//
//  UIDevice+TCExtension.swift
//  TCExtension
//
//  Created by Tony on 2020/7/10.
//  Copyright © 2020 East. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

public extension UIDevice {
    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isSimulator: Bool {
        UIDevice.current.model.contains("Simulator")
    }
    static var isJailBroken: Bool {
        if UIDevice.isSimulator {
            return false
        }
        let paths = ["/Applications/Cydia.app","/private/var/lib/apt/","/private/var/lib/cydia","/private/var/stash"]
        for item in paths {
            if FileManager.default.fileExists(atPath: item) {
                return true
            }
        }
        let bash = fopen("/bin/bash", "r")
        if bash != nil {
            fclose(bash)
            return true
        }
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            let path = "/private/\(uuid)"
            do {
                try "test".write(toFile: path, atomically: true, encoding: .utf8)
                if FileManager.default.fileExists(atPath: path) {
                    try FileManager.default.removeItem(atPath: path)
                    return true
                }
            } catch {
                
            }
        }
        
        return false
    }
    static var canMakePhoneCalls: Bool {
        UIApplication.shared.canOpenURL(URL(string: "tel://")!)
    }
    static var machineModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    static var machineModelName: String {
        switch self.machineModel {
        case "i386":
         return "32-bit Simulator"
        case "x86_64":
         return "64-bit Simulator"
        case "iPhone1,1":
         return "iPhone"
        case "iPhone1,2":
         return "iPhone 3G"
        case "iPhone2,1":
         return "iPhone 3GS"
        case "iPhone3,1":
         return "iPhone 4 (GSM)"
        case "iPhone3,2":
         return "iPhone 4 (GSM Rev A)"
        case "iPhone3,3":
         return "iPhone 4 (CDMA/Verizon/Sprint)"
        case "iPhone4,1":
         return "iPhone 4S"
        case "iPhone5,1":
         return "iPhone 5"
        case "iPhone5,2":
         return "iPhone 5"
        case "iPhone5,3":
         return "iPhone 5c"
        case "iPhone5,4":
         return "iPhone 5c"
        case "iPhone6,1":
         return "iPhone 5s"
        case "iPhone6,2":
         return "iPhone 5s"
        case "iPhone7,1":
         return "iPhone 6 Plus"
        case "iPhone7,2":
         return "iPhone 6"
        case "iPhone8,1":
         return "iPhone 6S"
        case "iPhone8,2":
         return "iPhone 6S Plus"
        case "iPhone8,4":
         return "iPhone SE"
        case "iPhone9,1":
         return "iPhone 7 (CDMA)"
        case "iPhone9,3":
         return "iPhone 7 (GSM)"
        case "iPhone9,2":
         return "iPhone 7 Plus (CDMA)"
        case "iPhone9,4":
         return "iPhone 7 Plus (GSM)"
        case "iPhone10,1":
         return "iPhone 8 (CDMA)"
        case "iPhone10,4":
         return "iPhone 8 (GSM)"
        case "iPhone10,2":
         return "iPhone 8 Plus (CDMA)"
        case "iPhone10,5":
         return "iPhone 8 Plus (GSM)"
        case "iPhone10,3":
         return "iPhone X (CDMA)"
        case "iPhone10,6":
         return "iPhone X (GSM)"
        case "iPhone11,2":
         return "iPhone XS"
        case "iPhone11,4":
         return "iPhone XS Max"
        case "iPhone11,6":
         return "iPhone XS Max China"
        case "iPhone11,8":
         return "iPhone XR"
        case "iPhone12,1":
         return "iPhone 11"
        case "iPhone12,3":
         return "iPhone 11 Pro"
        case "iPhone12,5":
         return "iPhone 11 Pro Max"
        case "iPhone12,8":
         return "iPhone SE (2nd Gen)"
        default:
            return "unknow"
        }
    }
    static var systemUptime: Date {
        Date(timeIntervalSinceNow: 0 - ProcessInfo.processInfo.systemUptime)
    }
//    static var ipAddressWIFI: String {
//        
//    }
//    static var ipAddressCell: String {
//        
//    }
    
}
