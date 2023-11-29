//
//  ManualSettingsViewController.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 31/10/2023.
//  Copyright © 2018 Exco. All rights reserved.
//
import UIKit
import MobileSDK

///
///
///
final class ManualSettingsViewController : UIViewController
{
    
    // MARK: - IBOutlets
    @IBOutlet private weak var appNameTextField     : UITextField!
    @IBOutlet private weak var bundleIDTextField    : UITextField!
    @IBOutlet private weak var playerIDTextField    : UITextField!
    @IBOutlet private weak var appCategoryTextField : UITextField!
    @IBOutlet private weak var appStoreIDTextField  : UITextField!
    @IBOutlet private weak var appStoreURLTextField : UITextField!
    @IBOutlet private weak var deviceIDTextField    : UITextField!
    @IBOutlet private weak var ifaTextField         : UITextField!
    @IBOutlet private weak var actionButton         : UIButton!
    
    private var initialPlayerID : String = "85958501-aa63-4317-b103-5ea9f3a276f8"

    // MARK: - Lifecycle
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        setupKeyboardDismissing()
        setupUI()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "dynamicPlayer" else { return }
        guard let target = segue.destination as? StandaloneExcoPlayerViewController else { return }
        
        let builder = ExcoMobileSDK.builder(with: playerIDFromCurrentTextFieldValues() ?? initialPlayerID)
            .set(applicationBundle: Bundle.main.bundleID)
            .set(applicationName: Bundle.main.appName)
            .set(webInspectable: true)
            .set(applicationCategories: appCategoryTextField.text)
            .set(appstoreId: appStoreIDTextField.text)
            .set(appstoreURL: appStoreURLTextField.text)
            .set(deviceIdentifer: deviceIDTextField.text)
            .set(deviceIFA: ifaTextField.text)
        
        target.configuration = builder.build()
    }
    
    // MARK: - View Setup
    private func setupKeyboardDismissing() 
    {
        let selector = #selector(UIView.endEditing)
        let tapGesture = UITapGestureRecognizer(target: view, action: selector)
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() 
    {
        appNameTextField.isEnabled = false
        bundleIDTextField.isEnabled = false
        playerIDTextField.autocapitalizationType = .none
        playerIDTextField.autocorrectionType = .no
        playerIDTextField.clearsOnBeginEditing = true
    }
    
    private func updateUI() 
    {
        appNameTextField.text  = Bundle.main.appName
        bundleIDTextField.text = Bundle.main.bundleID
        
        /// change color of placeholder text
        playerIDTextField.attributedPlaceholder = NSAttributedString(
            string: initialPlayerID,
            attributes: [.foregroundColor : UIColor.black]
        )
    }
    
    private func getCategoriesFrom(_ configArray: [String?]) -> String?
    {
        let nonNilArray = configArray.compactMap { $0 }
        guard !nonNilArray.isEmpty else { return nil }
        return nonNilArray.joined(separator: ", ")
    }
    
    // MARK: - User Actions
    @IBAction private func userDidTapStartButton() 
    {
        navigateToPlayerScreen()
    }
    
    // MARK: - Navigation
    private func navigateToPlayerScreen() 
    {
        guard playerIDFromCurrentTextFieldValues() != nil else {
            
            let alert = UIAlertController(title: "Error", message: "Player ID is missing", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel))
            present(alert, animated: true)
            return
        }
        performSegue(withIdentifier: "dynamicPlayer", sender: self)
    }
    
    private func playerIDFromCurrentTextFieldValues() -> String?
    {
        guard let playerIDText = playerIDTextField.text , !playerIDText.isEmpty else {
            return initialPlayerID
        }
        
        guard playerIDText.count != 36 else {
            return playerIDText
        }
        
        let alert = UIAlertController(title: "Invalid Player ID", message: "Player ID should be 36 characters long", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel))
        present(alert, animated: true)
        return nil
    }
}
