//
//  UIApplication_Extension.swift
//  TCExtension
//
//  Created by Tony on 2020/7/9.
//  Copyright © 2020 East. All rights reserved.
//

import Foundation
import UIKit

public extension UIApplication {
    var documentsURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }
    
    var documentsPath: String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }
    
    var cachesURL: URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last
    }
    
    var cachesPath: String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    
    var libraryURL: URL? {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last
    }
    
    var libraryPath: String? {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
    }
    
    var appBundleName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    }
    
    var appBundleID: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String ?? ""
    }
    
    var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    var appBuildVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
    
    var isPirated: Bool {
        func fileExistInMainBundle(_ fileName: String) -> Bool {
            let path = "\(Bundle.main.bundlePath)/\(fileName)"
            return FileManager.default.fileExists(atPath: path)
        }
        
        //TODO: 模拟器返回YES
        guard getgid() > 10 else {return true}
        guard Bundle.main.object(forInfoDictionaryKey: "SignerIdentity") == nil else {return true}
        guard fileExistInMainBundle("_CodeSignature") else {return true}
        guard fileExistInMainBundle("SC_Info") else {return true}
        return false
    }
//
//    var isBeginDebugged: Bool {
//        var size = sizeof()
//        size_t size = sizeof(struct kinfo_proc);
//        struct kinfo_proc info;
//        int ret = 0, name[4];
//        memset(&info, 0, sizeof(struct kinfo_proc));
//
//        name[0] = CTL_KERN;
//        name[1] = KERN_PROC;
//        name[2] = KERN_PROC_PID; name[3] = getpid();
//
//        if (ret == (sysctl(name, 4, &info, &size, NULL, 0))) {
//            return ret != 0;
//        }
//        return (info.kp_proc.p_flag & P_TRACED) ? YES : NO;
//    }
//
//    var memoryUsage: Int64 {
//
//    }
//
//    var cpuUsage: Int64 {
//
//    }
    
//    static var isAppExtension: Bool {
//        var result = false
//        if let _ = UIApplication.shared || Bundle.main.bundlePath.hasSuffix(".appex") {
//            result = true
//        }
//        return result
//    }
//
//    static var sharedExtesionApplication: UIApplication? {
//        return self.isAppExtension ? nil : UIApplication.shared
//    }
}
