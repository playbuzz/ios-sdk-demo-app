//
//  ConfigurationFormViewModel.swift
//  HostApp
//
//  Created by Eli Mehaudy on 24/12/2023.
//

import Foundation
import MobileSDK
import UIKit

class ConfigurationFormViewModel {
        
    var initialAppName: String {
        return Bundle.main.appName
    }
    
    var initialAppBundle: String {
        return Bundle.main.bundleID
    }
    
    var appVersion: String {
        return Bundle.main.appVersion
    }
    
    var idfa: String {
        let attService = HostAppAttServiceProvider()
        guard let idfa = attService.idfa else { return "IFA not provided" }
        return idfa
    }
    
    var navigationAction: ((UIViewController) -> ())?
    var initialPlayerID = Constants.PlayerIdConstants.playerIdWithAds
    
    private let selectedCreationType: ViewCreationType
    private let selectedContainerType: ViewContainerType
    
    init(selectedCreationType: ViewCreationType, selectedContainerType: ViewContainerType) {
        self.selectedCreationType = selectedCreationType
        self.selectedContainerType = selectedContainerType
    }
    
    func userDidTapNext(configuration: ExcoConfigurationModel) {
        let model = ExcoConfigurationModel(appName: configuration.appName,
                                           appBundle: configuration.appBundle,
                                           playerID: configuration.playerID,
                                           appCategory: configuration.appCategory,
                                           appStoreURL: configuration.appStoreURL,
                                           appVersion: configuration.appVersion,
                                           deviceID: configuration.deviceID,
                                           ifa: configuration.ifa)
        navigateToPlayerScreen(with: model)
    }
    
    private func navigateToPlayerScreen(with model: ExcoConfigurationModel) {
        let config = makeConfigurationObject(from: model)
        let playerScreenFactory = PlayerScreenFactory(viewCreationType: selectedCreationType, 
                                                      containerType: selectedContainerType,
                                                      configurations: [config])
        let playerScreen = playerScreenFactory.createPlayerScreen()
        navigationAction?(playerScreen)
    }
    
    private func makeConfigurationObject(from model: ExcoConfigurationModel) -> ExcoPlayerConfiguration {
        let configurationBuilder = ExcoMobileSDK.builder(with: model.playerID)
            .set(applicationName: model.appName)
            .set(applicationBundle: model.appBundle)
            .set(applicationCategories: model.appCategory)
            .set(appstoreURL: model.appStoreURL)
            .set(applicationVersion: model.appVersion)
            .set(deviceIdentifier: model.deviceID)
            .set(deviceIFA: model.ifa)
        return configurationBuilder.build()
    }
}
