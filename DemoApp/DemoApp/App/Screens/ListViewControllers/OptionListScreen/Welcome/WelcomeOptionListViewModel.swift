//
//  WelcomeOptionListViewModel.swift
//  HostApp
//
//  Created by Eli Mehaudy on 25/12/2023.
//

import UIKit
import MobileSDK

class WelcomeOptionListViewModel: ListViewModelProtocol {
    
    // MARK: - Private Properties
    private(set) var title = ""
    private(set) var subtitle = "Configuration Type"
    private(set) var description = "Select Your Preferred Configuration"
    // MARK: - Public Properties
    var navigationAction: ((UIViewController) -> ())?
    
    var cellsData: [OptionListCellModel] {
        return ConfigurationType.allCases.enumerated().compactMap { i, configType in
            return OptionListCellModel(title: configType.rawValue.capitalized, text: configType.text) { [weak self] in
                self?.handleSelection(selectedConfig: configType)
            }
        }
    }
    
    private let selectedCreationType: ViewCreationType
    private let selectedContainerType: ViewContainerType
    
    // MARK: Init
    init(selectedCreationType: ViewCreationType, selectedContainerType: ViewContainerType) {
        self.selectedCreationType = selectedCreationType
        self.selectedContainerType = selectedContainerType
    }
    
    func handleViewDidAppear() {
        requestAttPermissionIfNeeded()
    }
}

// MARK: Private
private extension WelcomeOptionListViewModel {
    func requestAttPermissionIfNeeded() {
        let attService = HostAppAttServiceProvider()
        attService.requestPermission()
    }
    
    func handleSelection(selectedConfig: ConfigurationType) {
        let viewController = getSelectedViewController(config: selectedConfig)
        navigationAction?(viewController)
    }
    
    func getSelectedViewController(config: ConfigurationType) -> UIViewController {
        switch config {
        case .predefined: return createPredefinedPlayerScreen()
        case .manual: return createConfigurationFormViewController()
        }
    }
    
    func createPredefinedPlayerScreen() -> UIViewController {
        let playerScreenFactory = PlayerScreenFactory(viewCreationType: selectedCreationType, 
                                                      containerType: selectedContainerType,
                                                      configurations: [getPredefinedConfiguration()])
        return playerScreenFactory.createPlayerScreen()
    }
    
    func createConfigurationFormViewController() -> UIViewController {
        let viewModel = ConfigurationFormViewModel(selectedCreationType: selectedCreationType, selectedContainerType: selectedContainerType)
        return ConfigurationFormViewController(viewModel: viewModel)
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
