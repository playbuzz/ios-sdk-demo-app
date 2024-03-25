//
//  XibView.swift
//  HostApp
//
//  Created by Eli Mehaudy on 26/12/2023.
//

import UIKit

/// Base view for custom UIViews made in xibs.
class XibView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        // Load the nib file
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: Self.self), owner: self, options: nil)?.first as? UIView {
            addSubview(view)
            view.ec_pinToSuperview()
        }
    }
}
