//
//  CustomTopView.swift
//  TestCode
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import UIKit

final class CustomTopView: UIView {
    
    private lazy var goLabel = CustomLabel(text: title,
                                           size: 20,
                                           weight: .semibold,
                                           color: .excoDarkBlue)
    
    private lazy var moveForwardLabel = CustomLabel(text: subtitle, size: 18)
    private lazy var topLabelsStack = CustomStackView(views: [goLabel, moveForwardLabel, UIView()], spacing: 5)
    
    private let title: String
    private let subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Constraints
private extension CustomTopView {
    func setupConstraints() {
        addSubview(topLabelsStack)
        topLabelsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topLabelsStack.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            topLabelsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topLabelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            topLabelsStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
