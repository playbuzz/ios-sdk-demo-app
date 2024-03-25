//
//  AppDelegate.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 31/10/2023.
//  Copyright © 2018 Exco. All rights reserved.
//
import UIKit
import MobileSDK
///
///
///
@main
class AppDelegate: UIResponder {
    private let crashReporterService: CrashReporterServiceProtocol = FirebaseCrashReporterService()
}

extension AppDelegate : ExcoMobileSDKDelegate {
    func mobileSDKDidActivateSuccessfully() {
        
    }
    
    func mobileSDKDidFailToActivate() {
        
    }
    
    func didFetchSDKJSFiles() {
        
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        crashReporterService.setup()
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ExcoMobileSDK.delegate = self
        ExcoMobileSDK.activate()
        ExcoMobileSDK.prefetchSDKJSFiles()
        
        /// disabling the screen idle timer in order to support long debug sessions
        UIApplication.shared.isIdleTimerDisabled = true
        // crashReporterService.forceCrash()
        logger.debug("")
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
