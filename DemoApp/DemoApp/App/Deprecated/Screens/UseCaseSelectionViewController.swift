//
//  ViewController.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 31/10/2023.
//  Copyright © 2018 Exco. All rights reserved.
//
import UIKit
import SwiftUI
///
///
///
enum DemoUseCase : CaseIterable
{
    case manual // xib based - in code
}
extension DemoUseCase : CustomStringConvertible
{
    var description : String
    {
        switch self
        {
        case .manual    : return "Manual"
        }
    }
}
///
///
///
class UseCaseSelectionViewController : UIViewController
{
    // MARK: - properties
    static var identifier : String { "DemoItem" }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView : UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate   = self
        }
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    // // MARK: -
    // func setupCrashButton() {
    //     let button = UIButton(type: .roundedRect)
    //     button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
    //     button.setTitle("Test Crash", for: [])
    //     button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
    //     view.addSubview(button)
    // }
    // @IBAction func crashButtonTapped(_ sender: AnyObject) {
    //     let numbers = [0]
    //     let _ = numbers[1]
    // }

    // // MARK: -
    // @IBSegueAction func showSwiftUIManual(_ coder: NSCoder) -> UIViewController? {
    //     let demoView = StaticIntegrationDemoView()
    //     return UIHostingController(coder: coder, rootView: demoView)
    // }
}
extension UseCaseSelectionViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        switch (indexPath.section,indexPath.item) {
        case (0,0): performSegue(withIdentifier: "manualStoryboard", sender: self)
        // case (0,1): performSegue(withIdentifier: "manualSwiftUI"   , sender: self)
        // case (1, 0): performSegue(withIdentifier: "", sender: self)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section {
        case 0: return "Use Case - Manual"
        case 1: return "Use Case - Predefined"
        case 2: return "Use Case - SwiftUI"
        default: return nil
        }
    }
}
extension UseCaseSelectionViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
        case 0: return 1
        case 1: return 1
        // case 2: return 2
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.identifier, for: indexPath)
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            // Configure content.
            content.text = DemoUseCase.allCases[indexPath.row].description
            // Customize appearance.
            content.imageProperties.tintColor = .red
            
            cell.contentConfiguration = content
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = DemoUseCase.allCases[indexPath.row].description
        }
        
        return cell
    }
}
