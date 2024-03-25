//
//  CustomScrollView.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import UIKit

final class CustomScrollView: UIScrollView {
    private lazy var contentView = UIView()
    
    // MARK: Init
    init(inputView: UIView) {
        super.init(frame: .zero)
        self.showsVerticalScrollIndicator = false
        setupContentView()
        setupInputView(view: inputView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Constraints
private extension CustomScrollView {
    func setupContentView() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.pinToSuperview(superview: self)
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func setupInputView(view: UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.pinToSuperview(superview: contentView)
    }
}
