//
//  ProgrammaticPlayerViewController.swift
//  HostApp
//
//  Created by Eli Mehaudy on 18/04/2024.
//

import UIKit
import MobileSDK

class ProgrammaticPlayerViewController: LoggerViewController {

    @IBOutlet private weak var excoPlayerView: ExcoPlayerView!
    @IBOutlet private weak var initButton: UIButton!
    @IBOutlet private weak var destroyButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var pauseButton: UIButton!
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var setIndexButton: UIButton!
    @IBOutlet private weak var fullScreenButton: UIButton!
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableViewLogDestination()
        setupPlayerView()
        setupPickerView()
        setupButtons()
    }
    
    private func addEvents() {
        excoPlayerView.addEventListenerOnProgrammaticPlayer("player-playing",listenerName: "player_playing_listener")
        excoPlayerView.addEventListenerOnProgrammaticPlayer("player-paused",listenerName: "player_paused_listener")
        excoPlayerView.addEventListenerOnProgrammaticPlayer("playlist-next-item",listenerName: "playlist_next_listener")
        excoPlayerView.addEventListenerOnProgrammaticPlayer("content-start",listenerName: "content_start_listener")

    }
    
    private func removeEventListeners() {
        excoPlayerView.removeEventListenerOffProgrammaticPlayer("player-playing",listenerName: "player_playing_listener")
        excoPlayerView.removeEventListenerOffProgrammaticPlayer("player-paused",listenerName: "player_paused_listener")
        excoPlayerView.removeEventListenerOffProgrammaticPlayer("playlist-next-item",listenerName: "playlist_next_listener")
        excoPlayerView.removeEventListenerOffProgrammaticPlayer("content-start",listenerName: "content_start_listener")
    }
    
    private func setupButtons() {
        initButton.asBlueStyledButton()
        destroyButton.asBlueStyledButton()
        playButton.asBlueStyledButton()
        pauseButton.asBlueStyledButton()
        setIndexButton.asBlueStyledButton()
        fullScreenButton.asBlueStyledButton()
    }
    
    private func setupPlayerView() {
        excoPlayerView.delegate = self
    }
    
    private func setupPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    @IBAction private func didTapInit(_ sender: UIButton) {
        excoPlayerView.initProgrammaticPlayer()
    }
    
    @IBAction private func didTapDestroy(_ sender: UIButton) {
        excoPlayerView.destroyProgrammaticPlayer()
    }
    
    @IBAction private func didTapPlay(_ sender: UIButton) {
        excoPlayerView.playProgrammaticPlayer()
    }
    
    @IBAction private func didTapPause(_ sender: UIButton) {
        excoPlayerView.pauseProgrammaticPlayer()
    }
    
    @IBAction func didTapFullScreen(_ sender: UIButton) {
        excoPlayerView.handleProgrammaticFullscreen(isFullScreen: true)
    }
    
    @IBAction private func didTapSetIndex(_ sender: UIButton) {
        let selectedIndex = pickerView.selectedRow(inComponent: 0)
        excoPlayerView.setPlaylistIndexInProgrammaticPlayer(selectedIndex)
    }
}

extension ProgrammaticPlayerViewController: ExcoPlayerViewDelegate {
    func playerView(_ playerView: ExcoPlayerView, didReceiveGenericEventWith payload: NSDictionary) {
        if let eventName = payload["name"] as? String,
           eventName != "content-time" {
            logger.info(payload)
        }
    }
}

extension ProgrammaticPlayerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3 // should return the count of the playlist elements
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row.description
    }
}

extension ProgrammaticPlayerViewController: UIPickerViewDelegate {}
