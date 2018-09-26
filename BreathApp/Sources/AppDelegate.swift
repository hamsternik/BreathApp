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
        
        var animations = [AnimationPhase]()
        do {
            animations = try breathAnimations() ?? []
        } catch {
            // TODO: Could present alert error dialog.
            print("Exception message: \(error.localizedDescription)")
        }
        
        let rootViewController = BreathConfigurator(
            storyboard: UIStoryboard(
                name: BreathConfigurator.Constants.storyboardTitle,
                bundle: .main
            ),
            animations: animations
        ).makeModule()
        
        window?.rootViewController = rootViewController
        
        return true
    }

}

extension AppDelegate {
    
    func breathAnimations() throws -> [AnimationPhase]? {
        let decoder = JSONDecoder()
        let resourceURL = Bundle.main.url(forResource: "phases", withExtension: "json")
        let resourceData = try resourceURL.flatMap { try Data.init(contentsOf: $0) }
        return try resourceData.flatMap { try decoder.decode([AnimationPhase].self, from: $0) }
    }
    
}
