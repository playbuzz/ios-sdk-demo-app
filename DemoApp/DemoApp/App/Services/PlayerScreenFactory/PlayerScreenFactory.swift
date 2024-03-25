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
    private let configuration: ExcoPlayerConfiguration
    
    // MARK: Init
    init(viewCreationType: ViewCreationType, configuration: ExcoPlayerConfiguration) {
        self.viewCreationType = viewCreationType
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
            return createPlayerStoryboardScreen(viewModel: viewModel)
        case .uiKit:
            return createPlayerProgrammaticScreen(viewModel: viewModel)
        case .swiftUI:
            return createPlayerSuiScreen(viewModel: viewModel)
        }
    }
    
    func createPlayerStoryboardScreen(viewModel: any PlayerScreenViewModelProtocol) -> UIViewController {
        return PlayerStoryboardScreen(viewModel: viewModel)
    }
    
    func createPlayerProgrammaticScreen(viewModel: any PlayerScreenViewModelProtocol) -> UIViewController {
        return PlayerUIKitScreen(viewModel: viewModel)
    }
    
    func createPlayerSuiScreen(viewModel: any PlayerScreenViewModelProtocol) -> UIViewController {
        let view = PlayerSwiftUIScreen(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func createPlayerScreenViewModel() -> any PlayerScreenViewModelProtocol {
        return PlayerScreenViewModel(configuration: configuration)
    }
}
