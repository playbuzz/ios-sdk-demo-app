//
//  ExtensionsUIButton.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 30/09/2024.
//

import UIKit

extension UIButton {
    func asBlueStyledButton() {
        backgroundColor = UIColor(named: "exco_dark_blue")
        layer.cornerRadius = 12
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }
}
