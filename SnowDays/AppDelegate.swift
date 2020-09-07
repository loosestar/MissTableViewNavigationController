//
//  AppDelegate.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 20/5/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication,
    		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    		-> Bool
	{
        let newVC = LS_DataTableViewController(style: .grouped)
//        let tbController = LS_TabBarController()
        let navController = UINavigationController(rootViewController: newVC)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}
