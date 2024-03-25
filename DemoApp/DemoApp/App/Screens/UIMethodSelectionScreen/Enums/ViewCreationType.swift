//
//  ViewCreationType.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import Foundation

enum ViewCreationType: String, CaseIterable {
    case storyboard = "Storyboard"
    case uiKit = "UIKit"
    case swiftUI = "SwiftUI"
    
    var description: String {
        switch self {
        case .storyboard:
            return "The screen will be created from interface builder"
        case .uiKit:
            return "The screen will be created with UIKit"
        case .swiftUI:
            return "The screen will be created with SwiftUI"
        }
    }
}
