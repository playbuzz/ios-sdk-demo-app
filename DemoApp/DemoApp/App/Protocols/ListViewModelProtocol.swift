//
//  ListViewModelProtocol.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 25/03/2024.
//

import Foundation
import UIKit

protocol ListViewModelProtocol {
    associatedtype Cell: Hashable
    var title: String { get }
    var subtitle: String { get }
    var description: String { get }
    var isNavigationBarHidden: Bool { get }
    var isTopLabelsContainerHidden: Bool { get }
    var navigationAction: ((UIViewController) -> ())? { get set }
    var cellsData: [Cell] { get }
}

extension ListViewModelProtocol {
    var isNavigationBarHidden: Bool {
        return self is WelcomeOptionListViewModel
    }
    
    var isTopLabelsContainerHidden: Bool {
        return !isNavigationBarHidden
    }
}
