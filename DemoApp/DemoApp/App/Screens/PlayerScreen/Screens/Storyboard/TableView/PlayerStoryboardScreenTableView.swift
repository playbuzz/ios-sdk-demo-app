//
//  PlayerStoryboardScreenTableView.swift
//  HostApp
//
//  Created by Eli Mehaudy on 24/12/2023.
//

import UIKit
import MobileSDK

class PlayerStoryboardScreenTableView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private let viewModel: any PlayerScreenViewModelProtocol
    private let tableViewController: SharedTableViewController
    
    // MARK: - Initializers
    init(viewModel: any PlayerScreenViewModelProtocol) {
        self.viewModel = viewModel
        self.tableViewController = SharedTableViewController(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the custom cell with the player view
        let cellWithPlayerNib = UINib(nibName: "CellWithPlayerTableViewCell", bundle: nil)
        tableView.register(cellWithPlayerNib, forCellReuseIdentifier: "CellWithPlayerTableViewCell")
        
        // Register a placeholder cell containing Lorem ipsum text
        let cellWithoutPlayerNib = UINib(nibName: "LoremTableViewCell", bundle: nil)
        tableView.register(cellWithoutPlayerNib, forCellReuseIdentifier: "LoremTableViewCell")
        tableView.dataSource = tableViewController
        tableView.delegate = tableViewController
    }
}
