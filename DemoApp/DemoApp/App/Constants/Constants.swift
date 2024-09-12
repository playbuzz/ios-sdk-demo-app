//
//  Constants.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 25/03/2024.
//

import Foundation
import MobileSDK

struct Constants {
    struct PlayerIdConstants {
        static let playerIdWithAds = "85958501-aa63-4317-b103-5ea9f3a276f8"
        static let playerIdWithoutAds = "8bd39116-eacb-4b4e-a160-bedd5d71ce1c"
    }
    
    private static let playerIds = [
        PlayerIdConstants.playerIdWithAds,
        PlayerIdConstants.playerIdWithoutAds,
        "a96ce1bb-38a5-4254-9f1d-ce3fad851846",
        "86066fa6-8c26-49fb-9670-692d04043b65",
        "b2c268b4-1897-4b22-bd41-ab710bb8c8d8",
        "2f6f745d-8e7a-42cf-9fc3-80a5cd41d637"]
    
    static var getPredefinedConfigurations: [ExcoPlayerConfiguration] = {
        Constants.playerIds.map { playerId in
            let attService = HostAppAttServiceProvider()
            let configurationBuilder = ExcoMobileSDK.builder(with: playerId)
            
                .set(applicationName: Bundle.main.appName)
                .set(applicationBundle: Bundle.main.bundleIdentifier)
                .set(applicationCategories: "Demo app")
                .set(appstoreURL: "my.app.appstore.url")
                .set(appstoreId: "appstore_id")
                .set(applicationVersion: Bundle.main.appVersion)
                .set(deviceIdentifier: "device_id")
                .set(deviceIFA: attService.idfa)
                .set(webInspectable: true)
            return configurationBuilder.build()
        }
    }()
}
