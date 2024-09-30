//
//  PlayerViewTableCell.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 29/09/2024.
//

import UIKit
import MobileSDK

class PlayerViewTableCell: UITableViewCell {

    @IBOutlet weak var excoPlayerView: ExcoPlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with playerId: String) {
        let configuration = ExcoMobileSDK.builder(with: playerId).build()
        do {
            try excoPlayerView.reuseConfiguration(configuration: configuration)
            titleLabel.text = playerId
        } catch {
            print(error)
        }
    }
}
