//
//  LoggerService.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 31/10/2023.
//  Copyright © 2018 Exco. All rights reserved.
//

import XCGLogger

let logger : XCGLogger = {
    
    let logger = XCGLogger(identifier: "com.exco.mobile.app", includeDefaultDestinations: false)
    // logger.add(destination: LoggerNamespace.consoleDestination)
    logger.add(destination: LoggerDestinations.crashlyticsDestination)
    logger.logAppDetails()
    
    return logger
}()

struct LoggerDestinations
{
    private init() {}
    
    // MARK: - XCGLogger Destinations
    static var consoleDestination: BaseQueuedDestination {
        
        let identifier  = "com.exco.mobile.app.console"
        let destination = ConsoleDestination(identifier: identifier)
        destination.outputLevel          = .debug
        destination.showLogIdentifier    = false
        destination.showFunctionName     = false
        destination.showThreadName       = false
        destination.showLevel            = false
        destination.showFileName         = false
        destination.showLineNumber       = false
        destination.showDate             = false
        destination.logQueue             = DispatchQueue(label: "\(identifier).queue", qos: .`default`)
        return destination
    }
    
    static var crashlyticsDestination : BaseQueuedDestination {
        let identifier  = "com.exco.mobile.app.crashlytics"
        let destination = CrashlyticsDestination(identifier: identifier)
        destination.outputLevel         = .debug
        destination.showLogIdentifier   = false
        destination.showFunctionName    = true
        destination.showThreadName      = false
        destination.showLevel           = true
        destination.showFileName        = true
        destination.showLineNumber      = true
        destination.showDate            = true
        destination.logQueue            = DispatchQueue(label: "\(identifier).queue", qos: .`default`)
        return destination
    }
    
    static var tableViewDestination : ListDestination {
        let identifier = "com.exco.mobile.app.list"
        return logger.destination(withIdentifier: identifier) as? ListDestination ?? _tableViewDestination
    }
    
    static var _tableViewDestination : ListDestination {
        let identifier = "com.exco.mobile.app.list"
        let destination = ListDestination(identifier: identifier)
        destination.outputLevel          = .info
        destination.showLogIdentifier    = false
        destination.showFunctionName     = true
        destination.showThreadName       = false
        destination.showLevel            = true
        destination.showFileName         = false
        destination.showLineNumber       = false
        destination.showDate             = true
        destination.logQueue             = DispatchQueue(label: "\(identifier).queue", qos: .userInitiated)
        return destination
    }
}

