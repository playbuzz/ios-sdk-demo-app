//
//  ViewContainerType.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 29/09/2024.
//

import Foundation

enum ViewContainerType: String, CaseIterable {
    case singleView
    case reusable
    
    var text: String {
        switch self {
            case .singleView:
                return "A single view with a player. (exm. PlayerView in UIScrollView)"
            case .reusable:
                return "A dynamic reusable view with a recycled player. (exm. Multiple PlayerView's in UITableView)"
        }
    }
}
