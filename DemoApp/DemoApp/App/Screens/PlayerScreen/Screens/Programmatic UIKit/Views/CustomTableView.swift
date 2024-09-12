//
//  CustomTableView.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import UIKit

final class CustomTableView: UITableView {
    private lazy var contentView = UIView()
    
    // MARK: Init
    init(inputView: UIView) {
        super.init(frame: .zero, style: .plain)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Constraints
private extension CustomTableView {
    func setupContentView() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.pinToSuperview(superview: self)
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}
