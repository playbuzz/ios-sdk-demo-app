//
//  ViewCreationTypeViewController.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import UIKit

final class ViewCreationTypeViewController: UIViewController {
    private lazy var topLabelsStack = CustomTopView(title: viewModel.mainTitle, subtitle: viewModel.mainSubTitle)
    
    private lazy var shadowView = ShadowView(offset: Constants.shadowOffset,
                                             opacity: Constants.shadowOpacity,
                                             radius: Constants.shadowRadius,
                                             cornerRadius: Constants.containerTopCornerRadius)
    
    private lazy var tableViewTitle = CustomLabel(text: viewModel.tableViewTitle,
                                                  size: Constants.titleFontSize,
                                                  weight: .semibold)
    private lazy var tableViewSubtitle = CustomLabel(text: viewModel.tableViewSubTitle, 
                                                     size: Constants.subtitleFontSize)
    
    private lazy var tableLabelsStack = CustomStackView(views: [tableViewTitle, tableViewSubtitle],
                                                            spacing: 5)
    
    private lazy var tableView = makeTableView()
    private lazy var mainStackView = makeMainStack()
    private lazy var dataSource = makeDataSource()
    
    private var viewModel: UIMethodSelectionViewModelProtocol
    
    // MARK: Init
    init(viewModel: UIMethodSelectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        applySnapshot()
        navigationAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func navigationAction() {
        viewModel.navigationAction = { [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: DataSource
private extension ViewCreationTypeViewController {
    func makeDataSource() -> UITableViewDiffableDataSource<Int, OptionListCellModel> {
        return UITableViewDiffableDataSource<Int, OptionListCellModel>(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: UIMethodTableViewCell.reuseIdentifier,
                for: indexPath) as? UIMethodTableViewCell else { return UITableViewCell() }
            cell.configureCell(with: item)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, OptionListCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.cellsData)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: UITableViewDelegate
extension ViewCreationTypeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(row: indexPath.row)
    }
}

// MARK: UI elements creation
private extension ViewCreationTypeViewController {
    func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(UIMethodTableViewCell.self,
                           forCellReuseIdentifier: UIMethodTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }
    
    func makeMainStack() -> CustomStackView {
        let stackView  = CustomStackView(views: [tableLabelsStack, tableView], spacing: 20)
        stackView.layoutMargins = UIEdgeInsets(top: Constants.topMargin,
                                               left: Constants.horizontalMargin,
                                               bottom: 0,
                                               right: Constants.horizontalMargin)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = Constants.containerTopCornerRadius
        return stackView
    }
}

// MARK: - Constants
private extension ViewCreationTypeViewController {
    struct Constants {
        static let shadowOffset: CGSize = CGSize(width: 0.0, height: -3.0)
        static let shadowOpacity: Float = 0.2
        static let shadowRadius: CGFloat = 4.0
        static let containerTopCornerRadius: CGFloat = 30.0
        static let topMargin: CGFloat = 40.0
        static let horizontalMargin: CGFloat = 20.0
        static let titleFontSize: CGFloat = 18.0
        static let subtitleFontSize: CGFloat = 17.0
        static let topViewHeigh: CGFloat = 150.0
        static let shadowViewOffset: CGFloat = -28
    }
}

// MARK: Constraints
private extension ViewCreationTypeViewController {
    func setupConstraints() {
        setupTopLabelsView()
        setupMainStack()
        setupShadow()
    }
    
    func setupTopLabelsView() {
        view.addSubview(topLabelsStack)
        topLabelsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topLabelsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLabelsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topLabelsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topLabelsStack.heightAnchor.constraint(equalToConstant: Constants.topViewHeigh)
        ])
    }
    
    func setupShadow() {
        view.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topLabelsStack.bottomAnchor,
                                            constant: Constants.shadowViewOffset),
            shadowView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupMainStack() {
        shadowView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.pinToSuperview(superview: shadowView)
    }
}
