//
//  ExcoConfigurationModel.swift
//  HostApp
//
//  Created by Eli Mehaudy on 26/12/2023.
//

import Foundation

struct ExcoConfigurationModel {
var appName: String?
var appBundle: String?
var playerID: String
var isWebInspectable: Bool
var appCategory: String?
var appStoreURL: String?
var appVersion: String?
var deviceID:String?
var ifa: String?
    
    init(appName: String?, appBundle: String?, playerID: String, isWebInspectable: Bool = true, appCategory: String? = nil, appStoreURL: String? = nil, appVersion: String? = nil, deviceID: String? = nil, ifa: String? = nil) {
        self.appName = appName
        self.appBundle = appBundle
        self.playerID = playerID
        self.isWebInspectable = isWebInspectable
        self.appCategory = appCategory
        self.appStoreURL = appStoreURL
        self.appVersion = appVersion
        self.deviceID = deviceID
        self.ifa = ifa
    }
}
