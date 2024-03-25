//
//  UIMethodTableViewCell.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import UIKit

final class UIMethodTableViewCell: UITableViewCell {
    static let reuseIdentifier = "UIMethodTableViewCell"
    
    private lazy var titleLabel = CustomLabel(text: "",
                                              size: 18,
                                              weight: .semibold,
                                              color: .excoLightBlue)
    
    private lazy var subtitleLabel = CustomLabel(text: "",
                                                 size: 16,
                                                 color: .excoMediumBlue)
    
    private lazy var disclosureImageView = DisclosureImageView(frame: .zero)
    
    private lazy var topStackView = CustomStackView(views: [titleLabel, UIView(), disclosureImageView],
                                                    spacing: 0,
                                                    axis: .horizontal)
    
    private lazy var mainStackView: CustomStackView = {
        let stackView = CustomStackView(views: [topStackView, subtitleLabel], spacing: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.layer.cornerRadius = 30
        stackView.backgroundColor = .excoDarkBlue
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with item: OptionListCellModel) {
        titleLabel.text = item.title
        subtitleLabel.text = item.text
    }
}

// MARK: Constraints
extension UIMethodTableViewCell {
    func setupConstraints() {
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
}
