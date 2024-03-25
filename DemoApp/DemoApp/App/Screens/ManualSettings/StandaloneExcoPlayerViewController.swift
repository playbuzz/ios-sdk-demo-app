//
//  ExCoPlayerDemoViewController.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 06/11/2023.
//
import UIKit
import MobileSDK
///
///
///
class StandaloneExcoPlayerViewController : LoggableViewController {
    
    private struct Constants
    {
        static let logTableCell       = "LogTableCell"
        static let reusableIdentifier = "reusableCell"
    }
    
    // MARK: - IBOutlets
    @IBOutlet private weak var playerIDLabel: UILabel!
    @IBOutlet private weak var excoPlayerView: ExcoPlayerView!
    
    // MARK: -
    internal var configuration: ExcoPlayerConfiguration!
    
    // MARK: - Initializers
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        logger.debug("")
        
        try? excoPlayerView.apply(player: configuration, shouldStore: false)
                
        setupUI()
        setupTableView()
        setupTableViewLogDestination()
    }
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        logger.debug("")
    }
    override func viewDidAppear(_ animated: Bool) 
    {
        super.viewDidAppear(animated)
        logger.debug("")
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
    }
    override func viewDidLayoutSubviews() 
    {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Private methods
    private func setupUI()
    {
        playerIDLabel.text = "PlayerID: \n\(excoPlayerView.playerConfiguration?.playerID ?? String() )"
    }
}

// MARK: - ExcoPlayerViewDelegate
extension StandaloneExcoPlayerViewController : ExcoPlayerViewDelegate
{
    
    // MARK: - Page load related methods
    func playerView(_ playerView: ExcoPlayerView, didFinishLoading playerID: String)
    {
        logger.info()
    }
    
    func playerView(_ playerView: ExcoPlayerView, didFailLoading playerID: String)
    {
        logger.info()
    }

    // MARK: - General/Content related methods

    func didFinishLoadingContent(to playerView: ExcoPlayerView)
    {
        logger.info()
    }

    func didStartPlayback(in playerView: ExcoPlayerView)
    {
        logger.info()
    }

    func didPausePlayback(in playerView: ExcoPlayerView)
    {
        logger.info()
    }
    
    func didClosePlayback(in playerView: ExcoPlayerView)
    {
        logger.info()
    }

    func didMutePlayback (in playerView: ExcoPlayerView)
    {
        logger.info()
    }

    func didUnmutePlayback(in playerView: ExcoPlayerView)
    {
        logger.info()
    }

    func playerView(_ playerView: ExcoPlayerView, wasClosed playerID: String)
    {
        logger.info()
    }

    
    func playerView(_ playerView: ExcoPlayerView, didClickCTAButton playerID: String)
    {
        logger.info()
    }

    // MARK: - Ad related methods

    func playerView(_ playerView: ExcoPlayerView, didInitiateAd playerID: String)
    {
        logger.info()
    }

    func playerView(_ playerView: ExcoPlayerView, didStartAdPlayback playerID: String)
    {
        logger.info()
    }
    
    func playerView(_ playerView: ExcoPlayerView, didImpressAd playerID: String)
    {
        logger.info()
    }
    
    func playerView(_ playerView: ExcoPlayerView, didReachFirstQuartile playerID: String)
    {
        logger.info()
    }
    
    func playerView(_ playerView: ExcoPlayerView, didReachSecondQuartile playerID: String)
    {
        logger.info()
    }
    
    func playerView(_ playerView: ExcoPlayerView, didReachThirdQuartile playerID: String)
    {
        logger.info()
    }
    
    func playerView(_ playerView: ExcoPlayerView, didCompleteAdPlayback playerID: String)
    {
        logger.info()
    }
    
    func playerView(_ playerView: ExcoPlayerView, didSkipAd playerID: String)
    {
        logger.info()
    }
    
    func playerView(_ playerView: ExcoPlayerView, didClickAd playerID: String)
    {
        logger.info()
    }
}
