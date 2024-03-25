//
//  FormFieldView.swift
//  HostApp
//
//  Created by Eli Mehaudy on 18/12/2023.
//

import UIKit

@IBDesignable
class FormFieldView: XibView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        titleLabel.text = title
        contentTextField.placeholder = placeHolder
        contentTextField.text = contentText
        contentTextField.delegate = self
    }
    
    @IBInspectable
    var title: String? = "Title" {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable
    var placeHolder: String? = "Placeholder" {
        didSet {
            contentTextField.placeholder = placeHolder
        }
    }
    
    @IBInspectable
    var contentText: String? = "" {
        didSet {
            contentTextField.text = contentText
        }
    }
}

extension FormFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        contentText = textField.text
        return true
    }
}
