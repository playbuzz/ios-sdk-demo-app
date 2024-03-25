//
//  HostAppAttServiceProvider.swift
//  HostApp
//
//  Created by Eli Mehaudy on 19/03/2024.
//

import Foundation
import AppTrackingTransparency
import AdSupport

class HostAppAttServiceProvider {
        
    var idfa: String? {
        if #available(iOS 14, *) {
            guard ATTrackingManager.trackingAuthorizationStatus == .authorized else { return nil }
        } else {
            guard ASIdentifierManager.shared().isAdvertisingTrackingEnabled else { return nil }
        }
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
        
    func requestPermission() {
        if #available(iOS 14, *) {
            DispatchQueue.main.async {
                ATTrackingManager.requestTrackingAuthorization { _ in }
            }
        }
    }
}
