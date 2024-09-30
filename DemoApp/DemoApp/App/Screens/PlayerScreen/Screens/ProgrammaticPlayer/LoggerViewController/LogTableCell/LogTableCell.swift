//
//  LogTableCell.swift
//  HostApp
//
//  Created by Eli Mehaudy on 26/11/2023.
//

import UIKit

class LogTableCell: UITableViewCell {

    @IBOutlet weak var logLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with text: String) {
        logLabel.text = text
    }
}
