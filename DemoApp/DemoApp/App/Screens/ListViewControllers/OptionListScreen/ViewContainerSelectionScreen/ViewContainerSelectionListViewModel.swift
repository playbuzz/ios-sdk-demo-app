//
//  ViewContainerSelectionListViewModel.swift
//  HostApp
//
//  Created by Eli Mehaudy on 25/12/2023.
//

import UIKit
import MobileSDK

class ViewContainerSelectionListViewModel: ListViewModelProtocol {
    
    // MARK: - Private Properties
    private let selectedCreationType: ViewCreationType
    private(set) var title = ""
    private(set) var subtitle = "View Container Type"
    private(set) var description = "Select A Single or Reusable container"
    // MARK: - Public Properties
    var navigationAction: ((UIViewController) -> ())?

    // MARK: Init
    init(selectedCreationType: ViewCreationType) {
        self.selectedCreationType = selectedCreationType
    }
    
    var cellsData: [OptionListCellModel] {
        return ViewContainerType.allCases.enumerated().compactMap { i, containerType in
            return OptionListCellModel(title: containerType.rawValue.capitalized, text: containerType.text) { [weak self] in
                self?.handleSelection(selectedContainerType: containerType)
            }
        }
    }
}

// MARK: Private
private extension ViewContainerSelectionListViewModel {
    // TODO: - Add ifMiniPlayer
    func handleSelection(selectedContainerType: ViewContainerType) {
        navigateToNextScreen(creationType: selectedCreationType, containerType: selectedContainerType)
    }
    
    func navigateToNextScreen(creationType: ViewCreationType, containerType: ViewContainerType) {
        switch containerType {
            case .singleView:
                let viewModel = WelcomeOptionListViewModel(selectedCreationType: creationType, selectedContainerType: containerType)
                let welcomeViewController = WelcomeOptionListViewController(viewModel: viewModel)
                navigationAction?(welcomeViewController)
            case .reusable:
                let playerScreenFactory = PlayerScreenFactory(viewCreationType: selectedCreationType, containerType: containerType, configuration: getPredefinedConfiguration())
                navigationAction?(playerScreenFactory.createPlayerScreen())
        }
    }
    
    func getPredefinedConfiguration() -> ExcoPlayerConfiguration {
        let attService = HostAppAttServiceProvider()
        let configurationBuilder = ExcoMobileSDK.builder(with: Constants.PlayerIdConstants.playerIdWithAds)
        // TODO: - Complete predefined attributes
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
}
