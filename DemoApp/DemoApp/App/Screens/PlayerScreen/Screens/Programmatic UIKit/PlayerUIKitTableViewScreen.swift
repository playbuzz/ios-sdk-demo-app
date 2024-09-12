//
//  PlayerUIKitTableViewScreen.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import UIKit
import MobileSDK

final class PlayerUIKitTableViewScreen: UIViewController {
    
    private let tableViewController: SharedTableViewController
    private lazy var playerView = makePlayerView()
    private lazy var tableView = CustomTableView(inputView: mainStackView)
    
    private lazy var mainStackView = CustomStackView(views: [playerView, titleLabel, subtitleLabel],
                                                     spacing: PlayerUIKitScreen.Constants.mainStackSpacing)
    
    private lazy var titleLabel = CustomLabel(text: viewModel.title,
                                              size: PlayerUIKitScreen.Constants.titleTextSize,
                                              weight: .semibold)
    
    private lazy var subtitleLabel = CustomLabel(text: viewModel.subtitle,
                                                 size: PlayerUIKitScreen.Constants.subtitleTextSize,
                                                 color: .gray)
    
    private let viewModel: any PlayerScreenViewModelProtocol
    
    // MARK: - Init
    init(viewModel: any PlayerScreenViewModelProtocol) {
        self.viewModel = viewModel
        self.tableViewController = SharedTableViewController(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func makePlayerView() -> ExcoPlayerView {
        let view = ExcoPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: PlayerUIKitScreen.Constants.aspectRatio
        ).isActive = true
        return view
    }
}

// MARK: Constraints
extension PlayerUIKitTableViewScreen {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pinToSuperview(superview: view, insets: PlayerUIKitScreen.Constants.insets, isRelativeToSafeArea: true)
        
        // Register the custom cell with the player view
        let cellWithPlayerNib = UINib(nibName: "CellWithPlayerTableViewCell", bundle: nil)
        tableView.register(cellWithPlayerNib, forCellReuseIdentifier: "CellWithPlayerTableViewCell")
        
        // Register a placeholder cell containing Lorem ipsum text
        let cellWithoutPlayerNib = UINib(nibName: "LoremTableViewCell", bundle: nil)
        tableView.register(cellWithoutPlayerNib, forCellReuseIdentifier: "LoremTableViewCell")
        tableView.dataSource = tableViewController
        tableView.delegate = tableViewController
    }
}
