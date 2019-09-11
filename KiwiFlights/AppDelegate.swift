//
//  AppDelegate.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 07/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else { fatalError() }
        
        coordinator = AppCoordinator(window: window)
        coordinator?.start()
        
        return true
    }
}

