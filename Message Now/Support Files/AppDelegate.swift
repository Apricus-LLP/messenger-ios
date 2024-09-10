//
//  AppDelegate.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 4/20/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var restrictRotation: UIInterfaceOrientationMask = .all

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if currentUser.id == nil { ApiUsersAuthentication.shared.signOutUser { (_, _) in } }
        
        UsersDatabase.shared.updateUserStatus(isOnline: true)
        let status = AprSdkDefaultSettings.shared.defaults.value(forKey: "status") as? Bool
        if status == nil { AprSdkDefaultSettings.shared.ChangeAvailability(status: true)}
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    {
        return restrictRotation
    }
}

