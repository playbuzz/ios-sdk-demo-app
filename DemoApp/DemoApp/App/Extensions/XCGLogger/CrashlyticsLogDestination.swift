//
//  CrashlyticsDestination.swift
//
//
//  Created by Arkadi Yoskovitz on 6/20/23.
//
import Foundation
import UIKit
import XCGLogger
import FirebaseCrashlytics
///
///
///
class CrashlyticsDestination: BaseQueuedDestination {
    // MARK: - Overridden Methods
    /// Print the log to the Apple System Log facility (using NSLog).
    ///
    /// - Parameters:
    ///     - message:   Formatted/processed message ready for output.
    ///
    /// - Returns:  Nothing
    ///
    open override func write(message: String) {
        let outputClosure = {
            let aTextArray : [CVarArg] = [message]
            Crashlytics.crashlytics().log(format: "%@", arguments: getVaList(aTextArray))
        }
        
        if let logQueue {
            logQueue.async(execute: outputClosure)
        } else {
            outputClosure()
        }
    }
}
