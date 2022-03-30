//
//  AppDelegate.swift
//  Benevits
//
//  Created by Fer on 25/03/22.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                     
            window = UIWindow(frame: UIScreen.main.bounds)
                   let vc = WelcomeViewController()
                   let navigationController = UINavigationController(rootViewController: vc)
                   window?.rootViewController = navigationController
                   window?.makeKeyAndVisible()
            
            
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.shouldResignOnTouchOutside = true
            IQKeyboardManager.shared.enableAutoToolbar = false
            
          
            return true
        }
    
    

}
