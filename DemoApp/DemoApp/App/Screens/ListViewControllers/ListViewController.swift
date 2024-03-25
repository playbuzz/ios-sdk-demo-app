//
//  OptionListViewController.swift
//  HostApp
//
//  Created by Eli Mehaudy on 17/12/2023.
//

import UIKit
import Combine

class ListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var titlesContainerView: UIView!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private lazy var dataSource = makeDataSource()
    var listViewModel: any ListViewModelProtocol {
        fatalError("override in subclass")
    }
    var cancellables = Set<AnyCancellable>()
        
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        applyExcoNavigationAppearance()
        applyExcoNavigationBackButton()
        setupTableView()
        setupLabels()
        applySnapshot()
        handleCellSelection()
        title = listViewModel.title
    }
    
    // MARK: - Override points
    func makeDataSource() -> UITableViewDiffableDataSource<Int, OptionListCellModel> {
        fatalError("Override in subclass")
    }
    
    func setupTableView() {
        tableView.delegate = self
    }
    
    func setupLabels() {
        subtitleLabel.text = listViewModel.subtitle
        descriptionLabel.text = listViewModel.description
    }
    
    func handleCellSelection() {
        fatalError("Override in subclass")
    }
    
    // MARK: - Private methods
    private func applySnapshot() {
        guard let items = listViewModel.cellsData as? [OptionListCellModel] else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Int, OptionListCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
