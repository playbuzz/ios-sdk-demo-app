//
//  ViewCreationTypeViewModel.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import UIKit

protocol UIMethodSelectionViewModelProtocol {
    var cellsData: [OptionListCellModel] { get }
    var mainTitle: String { get }
    var mainSubTitle: String {get }
    var tableViewTitle: String { get }
    var tableViewSubTitle: String { get }
    var navigationAction: ((UIViewController) -> ())? { get set }
    func didSelectItemAt(row: Int)
}

final class ViewCreationTypeViewModel: UIMethodSelectionViewModelProtocol {

    var navigationAction: ((UIViewController) -> ())?
    
    lazy var cellsData: [OptionListCellModel] = {
        return ViewCreationType.allCases.compactMap { method in
            OptionListCellModel(title: method.rawValue, text: method.description)
        }
    }()
    
    func didSelectItemAt(row: Int) {
        guard ViewCreationType.allCases.indices.contains(row) else { return }
        let selectedType = ViewCreationType.allCases[row]
        navigateToNextScreen(creationType: selectedType)
    }
    
    private func navigateToNextScreen(creationType: ViewCreationType) {
        let viewModel = WelcomeOptionListViewModel(selectedCreationType: creationType)
        let welcomeViewController = WelcomeOptionListViewController(viewModel: viewModel)
        navigationAction?(welcomeViewController)
    }
}

// MARK: VC Titles
extension ViewCreationTypeViewModel {
    var mainTitle: String { return Constants.mainTitle }
    var mainSubTitle: String { return Constants.mainSubTitle }
    var tableViewTitle: String { return Constants.tableViewTitle }
    var tableViewSubTitle: String { return Constants.tableViewSubTitle }
}

// MARK: Constants
private extension ViewCreationTypeViewModel {
    struct Constants {
        static let mainTitle: String = "Let's go"
        static let mainSubTitle: String = "Move forward with options"
        static let tableViewTitle: String = "UI method selection"
        static let tableViewSubTitle: String = "Select your preferred UI method"
    }
}
