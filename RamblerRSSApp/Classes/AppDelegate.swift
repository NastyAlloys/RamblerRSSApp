//
//  AppDelegate.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 2/2/16.
//  Copyright © 2016 Andrey Egorov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let appDependencies = AppDependencies()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        guard let window = window else { return false }
        appDependencies.installRootViewControllerIntoWindow(window)
        return true
    }
    
    
}