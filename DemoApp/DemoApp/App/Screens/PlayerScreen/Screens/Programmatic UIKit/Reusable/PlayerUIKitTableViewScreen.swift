//
//  PlayerUIKitTableViewScreen.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 29/09/2024.
//

import UIKit

class PlayerUIKitTableViewScreen: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Private properties
    private let viewModel: any PlayerScreenViewModelProtocol
    
    // MARK: - Initializers
    init(viewModel: any PlayerScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        tableView.register(UINib(nibName: PlayerViewTableCell.typeName, bundle: nil), forCellReuseIdentifier: PlayerViewTableCell.typeName)
        tableView.register(UINib(nibName: DummyTableCell.typeName, bundle: nil), forCellReuseIdentifier: DummyTableCell.typeName)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PlayerUIKitTableViewScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if /*indexPath.row == 3 || */indexPath.row == 1 {
            return handleCellWithPlayer(tableView: tableView, indexPath: indexPath)
        }
        return handleDummyCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    private func handleCellWithPlayer(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerViewTableCell.typeName, for: indexPath) as? PlayerViewTableCell else {
            return UITableViewCell()
        }
        let config = Constants.getPredefinedConfiguration[indexPath.row]
        try? cell.excoPlayerView.reuseConfiguration(configuration: viewModel.playerConfiguration)
        cell.titleLabel.text = config.playerID
        return cell
    }
    
    private func handleDummyCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DummyTableCell.typeName, for: indexPath) as? DummyTableCell else {
            return UITableViewCell()
        }
        return cell
    }
}

extension PlayerUIKitTableViewScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
