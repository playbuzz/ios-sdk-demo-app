//
//  ConfigurationFormViewController.swift
//  HostApp
//
//  Created by Eli Mehaudy on 18/12/2023.
//

import UIKit

class ConfigurationFormViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var appNameFormField: FormFieldView!
    @IBOutlet private weak var appBundleFormField: FormFieldView!
    @IBOutlet private weak var playerIdFormField: FormFieldView!
    @IBOutlet private weak var categoryFormField: FormFieldView!
    @IBOutlet private weak var appStoreURLFormField: FormFieldView!
    @IBOutlet private weak var appVersionFormField: FormFieldView!
    @IBOutlet private weak var devicesFormField: FormFieldView!
    @IBOutlet private weak var ifaFormField: FormFieldView!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK: - Private properties
    private let viewModel: ConfigurationFormViewModel
    
    // MARK: - Initializers
    init(viewModel: ConfigurationFormViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupInitialValues()
        setupKeyboardAvoiding()
        title = "Player Configuration"
    }
    
    // MARK: - Private methods
    private func setupButton() {
        nextButton.layer.cornerRadius = 20.0
    }
    
    private func setupInitialValues() {
        appNameFormField.contentText = viewModel.initialAppName
        appBundleFormField.contentText = viewModel.initialAppBundle
        playerIdFormField.contentText = viewModel.initialPlayerID
        appVersionFormField.contentText = viewModel.appVersion
        ifaFormField.contentText = viewModel.idfa
        viewModel.navigationAction = { [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func setupKeyboardAvoiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleKeyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            scrollView.contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: keyboardHeight, right: .zero)
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        }
    }
    
    @objc private func handleKeyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - IBAction
    @IBAction func didTapNext(_ sender: UIButton) {
        // TODO: - Handle player id errors
        guard let playerID = playerIdFormField.contentText else { return }
        let configuration = ExcoConfigurationModel(appName: appNameFormField.contentText,
                                                   appBundle: appBundleFormField.contentText,
                                                   playerID: playerID,
                                                   appCategory: categoryFormField.contentText,
                                                   appStoreURL: appStoreURLFormField.contentText,
                                                   appVersion: appVersionFormField.contentText,
                                                   deviceID: devicesFormField.contentText,
                                                   ifa: ifaFormField.contentText)
        viewModel.userDidTapNext(configuration: configuration)
    }
}
