//
//  AppDelegate.swift
//  Test
//
//  Created by Алексей Папин on 14.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()

        UsersMainModule.create().presentAsNavController()
        
        return true
    }

}

extension AppDelegate {
    static var currentDelegate: AppDelegate {
        return currenctApplication.delegate as! AppDelegate
    }
    
    static var currentWindow: UIWindow {
        return currentDelegate.window!
    }
    
    static var currenctApplication: UIApplication {
        return UIApplication.shared
    }
}
