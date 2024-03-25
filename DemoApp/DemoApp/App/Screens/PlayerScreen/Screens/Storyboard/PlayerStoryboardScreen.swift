//
//  PlayerStoryboardScreen.swift
//  HostApp
//
//  Created by Eli Mehaudy on 24/12/2023.
//

import UIKit
import MobileSDK

class PlayerStoryboardScreen: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var playerView: ExcoPlayerView!
    
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
    }
}
