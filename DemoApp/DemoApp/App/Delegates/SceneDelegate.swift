//
//  SceneDelegate.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 31/10/2023.
//  Copyright © 2018 Exco. All rights reserved.
//
import UIKit
///
///
///
class SceneDelegate: UIResponder {
    var window: UIWindow?
    private var navigationController: UINavigationController?
    
    fileprivate func launchFirstScreen() {
        let welcomeViewController = ViewCreationTypeViewController(viewModel: ViewCreationTypeViewModel())
        navigationController = UINavigationController(rootViewController: welcomeViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    fileprivate func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .excoDarkBlue
        let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white] //alter to fit your needs
        appearance.titleTextAttributes = titleAttribute
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    fileprivate func setupNavigationBackButton() {
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

extension SceneDelegate: UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        launchFirstScreen()
        setupNavigationController()
        setupNavigationBackButton()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
