//
//  ConfigurationType.swift
//  HostApp
//
//  Created by Eli Mehaudy on 24/12/2023.
//

import Foundation
import MobileSDK

enum ConfigurationType: String, CaseIterable {
    case predefined
    case manual
    
    var text: String {
        switch self {
            case .predefined:
                return "\(String(describing: ExcoPlayerConfiguration.self)) defined in Storyboard attributes."
            case .manual:
                return "\(String(describing: ExcoPlayerConfiguration.self)) needs to be defined and passed with function 'apply(player configuration: ExcoPlayerConfiguration, shouldStore inCache: Bool)' inside `\(String(describing: ExcoPlayerView.self))`."
        }
    }
}
