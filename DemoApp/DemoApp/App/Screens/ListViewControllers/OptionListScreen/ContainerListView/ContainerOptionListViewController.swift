//
//  ContainersOptionListViewController.swift
//  HostApp
//
//  Created by Eli Mehaudy on 25/12/2023.
//

import UIKit

class ContainerOptionListViewController: OptionListViewController {
    
    // MARK: - Properties
    private let viewModel: ContainerOptionListViewModel
    override var listViewModel: any ListViewModelProtocol { return viewModel }
    
    // MARK: - Initializers
    init(viewModel: ContainerOptionListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: OptionListViewController.typeName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Points
    override func handleCellSelection() {
        viewModel.navigationAction = { [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
