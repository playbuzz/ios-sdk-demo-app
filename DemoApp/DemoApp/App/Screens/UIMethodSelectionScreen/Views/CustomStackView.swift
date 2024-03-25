//
//  CustomStackView.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import UIKit

final class CustomStackView: UIStackView {
    init(views: [UIView], spacing: CGFloat, axis: NSLayoutConstraint.Axis = .vertical) {
        super.init(frame: .zero)
        self.axis = axis
        self.spacing = spacing
        views.forEach({ addArrangedSubview($0) })
        self.isLayoutMarginsRelativeArrangement = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
