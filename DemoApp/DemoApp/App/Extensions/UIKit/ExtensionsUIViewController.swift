//
//  ExtensionsUIViewController.swift
//  HostApp
//
//  Created by Eli Mehaudy on 24/12/2023.
//

import UIKit

extension UIViewController {
    
    func applyExcoNavigationAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .excoDarkBlue
        let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white] //alter to fit your needs
        appearance.titleTextAttributes = titleAttribute
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    func applyExcoNavigationBackButton() {
        let backButton = UIButton(type: .custom)
        let backButtonImage = UIImage(named: "back_arrow_empty")
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationItem.leftBarButtonItem = barButtonItem
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc
    private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension UIViewController: TypeNameable { }
