//
//  SharedTableViewController.swift
//  HostApp
//
//  Created by Alex Pinhasov on 05/09/2024.
//

import Foundation
import UIKit

class SharedTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel: any PlayerScreenViewModelProtocol
    
    init(viewModel: any PlayerScreenViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 1.2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 3 || indexPath.row == 1) {
            return handleCellWithPlayer(tableView: tableView, indexPath: indexPath)
        }
        
        return handleCellWithOutPlayer(tableView: tableView, indexPath: indexPath)
    }
    
    private func handleCellWithPlayer(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithPlayerTableViewCell", for: indexPath) as? CellWithPlayerTableViewCell else {
            return UITableViewCell()
        }
        let configuration = viewModel.playerConfigurations[indexPath.row]
//        try? cell.playerContainerView.reuseConfiguration(configuration: configuration)
        cell.titleLabel.text = configuration.playerID
        
        return cell
    }
    
    private func handleCellWithOutPlayer(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoremTableViewCell", for: indexPath) as? LoremTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
