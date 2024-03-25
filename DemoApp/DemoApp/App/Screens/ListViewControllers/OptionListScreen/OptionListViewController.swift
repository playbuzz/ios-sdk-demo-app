//
//  OptionListViewController.swift
//  HostApp
//
//  Created by Eli Mehaudy on 25/12/2023.
//

import UIKit

class OptionListViewController: ListViewController {
    // MARK: - Constants
    private struct Constants {
        static let shadowOffset = CGSize(width: 0.0, height: -3.0)
        static let shadowOpacity: Float = 0.2
        static let shadowRadius: CGFloat = 4.0
        static let containerTopCornerRadius: CGFloat = 30.0
    }
    
    // MARK: - IBOutlet
    @IBOutlet private weak var topLabelsContainerView: UIView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopContainerView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        applyShadow()
    }
    
    // MARK: - Override Points
    override func makeDataSource() -> UITableViewDiffableDataSource<Int, OptionListCellModel> {
        return UITableViewDiffableDataSource<Int, OptionListCellModel>(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionListTableCell.typeName, for: indexPath) as? OptionListTableCell else { return UITableViewCell() }
            cell.configureCell(with: item)
            return cell
        }
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableView.register(UINib(nibName: OptionListTableCell.typeName, bundle: nil), forCellReuseIdentifier: OptionListTableCell.typeName)
    }
    
    // MARK: - Private Methods
    private func setupTopContainerView() {
        topLabelsContainerView.isHidden = listViewModel.isTopLabelsContainerHidden
    }
    
    private func applyShadow() {
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = Constants.shadowOffset
        shadowView.layer.shadowOpacity = Constants.shadowOpacity
        shadowView.layer.shadowRadius = Constants.shadowRadius
        shadowView.layer.masksToBounds = false
        shadowView.layer.cornerRadius = Constants.containerTopCornerRadius
        titlesContainerView.layer.cornerRadius = Constants.containerTopCornerRadius
    }
}
