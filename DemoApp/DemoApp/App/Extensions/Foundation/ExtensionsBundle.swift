//
//  ExtensionsBundle.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 28/11/2023.
//
import Foundation
///
///
///
extension Bundle {
    
    var appName: String 
    {
        if let displayName = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return displayName
        } else if let bundleName = object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        } else {
            return "missing app name"
        }
    }
    
    var bundleID: String 
    {
        if let bundleIdentifier = bundleIdentifier {
            return bundleIdentifier
        } else {
            return "missing bundle id"
        }
    }
}
