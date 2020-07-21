//
//  AppDelegate.swift
//  FantasyKit
//
//  Created by Tony Chen on 7/14/20.
//  Copyright © 2020 Tony Chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    public var window: UIWindow? = nil


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

}

