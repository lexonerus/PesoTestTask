//
//  AppDelegate.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 12.07.2022.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainNavigationController = UINavigationController(rootViewController: FirstViewController())
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        window?.rootViewController = mainNavigationController
        
        
        return true
    }




}

