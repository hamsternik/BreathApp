//
//  AppDelegate.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 7/1/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        let rootStoryboard = UIStoryboard(name: "Breath", bundle: .main)
        let rootViewController = rootStoryboard.instantiateViewController(withIdentifier: "BreathViewController")
        window?.rootViewController = rootViewController
        
        return true
    }

}
