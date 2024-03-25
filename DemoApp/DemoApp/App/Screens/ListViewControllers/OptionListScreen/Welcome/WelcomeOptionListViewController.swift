//
//  WelcomeOptionListViewController.swift
//  HostApp
//
//  Created by Eli Mehaudy on 25/12/2023.
//

import UIKit

class WelcomeOptionListViewController: OptionListViewController {
    
    // MARK: - Properties
    private let viewModel: WelcomeOptionListViewModel
    override var listViewModel: any ListViewModelProtocol { return viewModel }
    
    // MARK: - Initializers
    init(viewModel: WelcomeOptionListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: OptionListViewController.typeName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.handleViewDidAppear()
    }
    
    // MARK: - Override Points
    override func handleCellSelection() {
        viewModel.navigationAction = { [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
