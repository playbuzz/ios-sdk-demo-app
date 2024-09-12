//
//  PlayerUIKitScreen.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import UIKit
import MobileSDK

final class PlayerUIKitScreen: UIViewController {
    
    private lazy var playerView = makePlayerView()
    private lazy var scrollView = CustomScrollView(inputView: mainStackView)
    
    private lazy var mainStackView = CustomStackView(views: [playerView, titleLabel, subtitleLabel],
                                                    spacing: Constants.mainStackSpacing)
    
    private lazy var titleLabel = CustomLabel(text: viewModel.title,
                                              size: Constants.titleTextSize,
                                              weight: .semibold)
    
    private lazy var subtitleLabel = CustomLabel(text: viewModel.subtitle,
                                                 size: Constants.subtitleTextSize,
                                                 color: .gray)
    
    private let viewModel: any PlayerScreenViewModelProtocol
    
    // MARK: - Init
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
        view.backgroundColor = .white
        setupScrollView()
        setupPlayer()
    }
    
    private func setupPlayer() {
        guard let playerConfiguration = viewModel.playerConfigurations.first else {
            print("Missing player configuration at \(#function)")
            return
        }
        do {
            try playerView.apply(player: playerConfiguration, shouldStore: false)
        } catch {
            print(error)
        }
    }
    
    private func makePlayerView() -> ExcoPlayerView {
        let view = ExcoPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: Constants.aspectRatio
        ).isActive = true
        return view
    }
}

// MARK: Ext Constants
extension PlayerUIKitScreen {
    struct Constants {
        static let aspectRatio: CGFloat = 16.0 / 9.0
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 16.0,
                                                       left: 16.0,
                                                       bottom: 16.0,
                                                       right: 16.0)
        static let titleTextSize: CGFloat = 20.0
        static let subtitleTextSize: CGFloat = 17.0
        static let mainStackSpacing: CGFloat = 20.0
    }
}

// MARK: Constraints
extension PlayerUIKitScreen {
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.pinToSuperview(superview: view, insets: Constants.insets, isRelativeToSafeArea: true)
    }
}
