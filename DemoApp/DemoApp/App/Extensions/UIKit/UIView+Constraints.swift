//
//  ExtensionsUIView+Constraints.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 29/01/2024.
//

import UIKit

extension UIView {
    func pinToSuperview(superview: UIView? = nil, 
                        insets: UIEdgeInsets = .zero,
                        isRelativeToSafeArea: Bool = false) {
        guard let superview else { return }

        let targetTopAnchor = isRelativeToSafeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor
        let targetLeadingAnchor = isRelativeToSafeArea ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor
        let targetTrailingAnchor = isRelativeToSafeArea ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor
        let targetBottomAnchor = isRelativeToSafeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: targetTopAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: targetLeadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: targetTrailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: targetBottomAnchor, constant: -insets.bottom),
        ])
    }
}
