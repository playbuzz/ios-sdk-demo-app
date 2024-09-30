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
    private let configuration: ExcoPlayerConfiguration
    
    // MARK: Init
    init(viewCreationType: ViewCreationType, containerType: ViewContainerType, configuration: ExcoPlayerConfiguration) {
        self.viewCreationType = viewCreationType
        self.containerType = containerType
        self.configuration = configuration
    }
    
    func createPlayerScreen() -> UIViewController {
        let viewModel = createPlayerScreenViewModel()
        return createScreenOfCertainType(viewModel: viewModel, type: viewCreationType)
    }
}

// MARK: Private
private extension PlayerScreenFactory {
    func createScreenOfCertainType(viewModel: any PlayerScreenViewModelProtocol,
                                   type: ViewCreationType) -> UIViewController {
        switch type {
            case .storyboard:
                return createPlayerStoryboardScreen()
            case .uiKit:
                return createPlayerProgrammaticScreen(viewModel: viewModel)
            case .swiftUI:
                return createPlayerSuiScreen(viewModel: viewModel)
            case .programmaticPlayer:
                return createProgrammaticPlayerScreen()
        }
    }
    
    func createPlayerStoryboardScreen() -> UIViewController {
        return PlayerStoryboardScreen()
    }
    
    func createPlayerProgrammaticScreen(viewModel: any PlayerScreenViewModelProtocol) -> UIViewController {
        switch containerType {
            case .singleView:
                return PlayerUIKitScreen(viewModel: viewModel)
            case .reusable:
                return PlayerUIKitTableViewScreen(viewModel: viewModel)
        }
    }
    
    func createPlayerSuiScreen(viewModel: any PlayerScreenViewModelProtocol) -> UIViewController {
        switch containerType {
            case .singleView:
                let view = PlayerSwiftUIScreen(viewModel: viewModel)
                return UIHostingController(rootView: view)
            case .reusable:
                let view = PlayerSwiftUIListScreen(viewModel: viewModel)
                return UIHostingController(rootView: view)
        }
    }
    
    func createProgrammaticPlayerScreen() -> UIViewController {
        return ProgrammaticPlayerViewController()
    }
    
    func createPlayerScreenViewModel() -> any PlayerScreenViewModelProtocol {
        return PlayerScreenViewModel(configuration: configuration)
    }
}
