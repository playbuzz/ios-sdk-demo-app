//
//  CustomLabel.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 25/01/2024.
//

import UIKit

final class CustomLabel: UILabel {
    init(text: String, size: CGFloat, weight: UIFont.Weight = .regular, color: UIColor = .black) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = color
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
