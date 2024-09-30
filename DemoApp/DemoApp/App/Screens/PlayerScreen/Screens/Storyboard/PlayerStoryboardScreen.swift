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
    
    // MARK: - Initializers
    init() {
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
