//
//  SimpleTitleTableCell.swift
//  HostApp
//
//  Created by Eli Mehaudy on 17/12/2023.
//

import UIKit

class SimpleTitleTableCell: UITableViewCell {

    @IBOutlet private weak var cellContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    private var action: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContainerView()
    }
    
    func configureCell(with item: OptionListCellModel) {
        titleLabel.text = item.title
        action = item.action
    }
    
    private func setupContainerView() {
        cellContainerView.ex_applyBorder(color: UIColor.excoDarkBlue.cgColor, cornerRadius: 20.0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(userDidSelectCell))
        cellContainerView.addGestureRecognizer(tap)
    }
    
    @objc
    private func userDidSelectCell() {
        action?()
    }
}
