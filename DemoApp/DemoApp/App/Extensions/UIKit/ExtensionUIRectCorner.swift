//
//  ExtensionUIRectCorner.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import UIKit

extension UIRectCorner: CaseIterable {
    public static var allCases: [UIRectCorner] {
        return [.topLeft, .topRight, .bottomLeft, .bottomRight]
    }
    
    var title: String {
        switch self {
        case .topLeft: return "Top Left"
        case .topRight: return "Top Right"
        case .bottomLeft: return "Bottom Left"
        case .bottomRight: return "Bottom Right"
        default: return "Error: No such title"
        }
    }
}
