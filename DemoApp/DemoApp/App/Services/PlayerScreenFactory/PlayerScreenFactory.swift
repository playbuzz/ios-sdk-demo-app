//
//  PlayerScreenFactory.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 28/01/2024.
//

import UIKit
import SwiftUI
import MobileSDK

protocol PlayerScreenFactoryProtocol {
    func createPlayerScreen() -> UIViewController
}

final class PlayerScreenFactory: PlayerScreenFactoryProtocol {
    private let viewCreationType: ViewCreationType
    private let containerType: ViewContainerType
    private let configurations: [ExcoPlayerConfiguration]
    
    // MARK: Init
    init(viewCreationType: ViewCreationType, containerType: ViewContainerType, configurations: [ExcoPlayerConfiguration]) {
        self.viewCreationType = viewCreationType
        self.containerType = containerType
        self.configurations = configurations
    }
    
    func createPlayerScreen() -> UIViewController {
        let viewModel = createPlayerScreenViewModel()
        return createScreenOfCertainType(viewModel: viewModel, type: viewCreationType, container: containerType)
    }
}

// MARK: Private
private extension PlayerScreenFactory {
    func createScreenOfCertainType(viewModel: any PlayerScreenViewModelProtocol,
                                   type: ViewCreationType,
                                   container: ViewContainerType) -> UIViewController {
        switch type {
        case .storyboard:
            return createPlayerStoryboardScreen(viewModel: viewModel, container: container)
        case .uiKit:
            return createPlayerProgrammaticScreen(viewModel: viewModel, container: container)
        case .swiftUI:
            return createPlayerSuiScreen(viewModel: viewModel, container: container)
        }
    }
    
    func createPlayerStoryboardScreen(viewModel: any PlayerScreenViewModelProtocol, container: ViewContainerType) -> UIViewController {
        switch container {
        case .singleView: return PlayerStoryboardScreen(viewModel: viewModel)
        case .reusable: return PlayerStoryboardScreenTableView(viewModel: viewModel)
        }
    }
    
    func createPlayerProgrammaticScreen(viewModel: any PlayerScreenViewModelProtocol, container: ViewContainerType) -> UIViewController {
        switch container {
        case .singleView: return PlayerUIKitScreen(viewModel: viewModel)
        case .reusable: return PlayerUIKitTableViewScreen(viewModel: viewModel)
        }
    }
    
    func createPlayerSuiScreen(viewModel: any PlayerScreenViewModelProtocol, container: ViewContainerType) -> UIViewController {
        switch container {
        case .singleView:
            return UIHostingController(rootView: PlayerSwiftUIScreen(viewModel: viewModel))
        case .reusable:
            return UIHostingController(rootView: PlayerSwiftUIListScreen(viewModel: viewModel))
        }
    }
    
    func createPlayerScreenViewModel() -> any PlayerScreenViewModelProtocol {
        return PlayerScreenViewModel(configurations: configurations)
    }
}
