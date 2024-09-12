//
//  ContainerOptionListViewModel.swift
//  HostApp
//
//  Created by Eli Mehaudy on 25/12/2023.
//

import UIKit
import MobileSDK

class ContainerOptionListViewModel: ListViewModelProtocol {
    
    // MARK: - Private Properties
    private(set) var title = ""
    private(set) var subtitle = "Container Type"
    private(set) var description = "Select A Container Possibility"
    // MARK: - Public Properties
    var navigationAction: ((UIViewController) -> ())?
    
    var cellsData: [OptionListCellModel] {
        return ViewContainerType.allCases.enumerated().compactMap { i, configType in
            return OptionListCellModel(title: configType.rawValue.capitalized, text: configType.text) { [weak self] in
                self?.handleSelection(selectedConfig: configType)
            }
        }
    }
    
    private let selectedCreationType: ViewCreationType
    
    // MARK: Init
    init(selectedCreationType: ViewCreationType) {
        self.selectedCreationType = selectedCreationType
    }
}

// MARK: Private
private extension ContainerOptionListViewModel {
    func handleSelection(selectedConfig: ViewContainerType) {
        let viewController = getSelectedViewController(config: selectedConfig)
        navigationAction?(viewController)
    }
    
    func getSelectedViewController(config: ViewContainerType) -> UIViewController {
        switch config {
        case .singleView:
            let viewModel = WelcomeOptionListViewModel(selectedCreationType: self.selectedCreationType, selectedContainerType: config)
            let welcomeViewController = WelcomeOptionListViewController(viewModel: viewModel)
            return welcomeViewController
        case .reusable:
            let playerScreenFactory = PlayerScreenFactory(viewCreationType: selectedCreationType,
                                                          containerType: config,
                                                          configurations: Constants.getPredefinedConfigurations)
            return playerScreenFactory.createPlayerScreen()
        }

    }
}
