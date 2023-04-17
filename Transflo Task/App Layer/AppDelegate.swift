//
//  AppDelegate.swift
//  Transflo Task
//
//  Created by Youssef on 15/04/2023.
//

import UIKit
import AlamofireEasyLogger

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let alamofireLogger = FancyAppAlamofireLogger(prettyPrint: true) {
        print($0)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController())        
                
        return true
    }
}
