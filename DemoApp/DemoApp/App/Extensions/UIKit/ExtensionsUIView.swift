//
//  ExtensionsUIView.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 28/11/2023.
//
import UIKit
///
///
///
internal extension UIView {
    var ec_allSubviews: [UIView] {
        subviews + subviews.flatMap({ $0.ec_allSubviews })
    }
    
    func ex_applyBorder(width: CGFloat = 1.0, color: CGColor, cornerRadius: CGFloat? = nil) {
        layer.borderWidth = width
        layer.borderColor = color
        if let cornerRadius {
            layer.cornerRadius = cornerRadius
        }
    }
    
    func ec_pinToSuperview() {
        guard let superview = self.superview else { return }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}

extension UIView: TypeNameable { }
