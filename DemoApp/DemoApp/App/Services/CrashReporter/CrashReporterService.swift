//
//  CrashReporterService.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 31/10/2023.
//  Copyright © 2018 Exco. All rights reserved.
//

import FirebaseCore

protocol CrashReporterServiceProtocol {
    func setup()
    func forceCrash()
}

class FirebaseCrashReporterService: CrashReporterServiceProtocol {
    
    func setup() {
        FirebaseApp.configure()
    }
    
    func forceCrash() {
        // in order to test that crashlytics is integrated properly:
        // 1. run the app in simulator
        // 2. stop the run in xcode (this step disconnects the debugger)
        // 3. run the app from the simulator home screen directly
        // 4. crash
        // 5. run through xcode again to update firebase dashboard
        logger.debug("intentionally crash in order to test crashlytics integration")
        let array = [0]
        let _ = array[1]
    }
}
