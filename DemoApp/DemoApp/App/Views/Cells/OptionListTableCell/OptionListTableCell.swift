//
//  OptionListTableCell.swift
//  HostApp
//
//  Created by Eli Mehaudy on 17/12/2023.
//

import UIKit

class OptionListTableCell: UITableViewCell {

    @IBOutlet private weak var cellContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    private var action: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContainerView()
    }
    
    func configureCell(with item: OptionListCellModel) {
        titleLabel.text = item.title
        descriptionLabel.text = item.text
        action = item.action
    }
    
    private func setupContainerView() {
        cellContainerView.layer.cornerRadius = 20.0
        let tap = UITapGestureRecognizer(target: self, action: #selector(userDidSelectCell))
        cellContainerView.addGestureRecognizer(tap)
    }
    
    @objc
    private func userDidSelectCell() {
        action?()
    }
}
