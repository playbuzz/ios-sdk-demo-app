//
//  LoggerViewController.swift
//  HostApp
//
//  Created by Eli Mehaudy on 02/05/2024.
//

import UIKit

class LoggerViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var logTableView: UITableView!
    // MARK: - Properties
    private var reuseIdentifier: String { "reusableCell" }
    private var logMessages: [String] = []
    private var logDestination: ListDestination?
    
    internal func setupTableView() {
        logTableView.dataSource = self
        logTableView.register(UINib(nibName: "LogTableCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
    internal func setupTableViewLogDestination() {
        let destination = LoggerDestinations.tableViewDestination
        destination.delegate = self
        logger.add(destination: destination)
        logger.logAppDetails()
        logDestination = destination
    }
    
    func onLogMessageReceived(_ message: String) {
        logMessages.append(message)
        logTableView.reloadData()
        scrollToBottom()
    }
    
    private func scrollToBottom() {
        let numberOfRows = logTableView.numberOfRows(inSection: 0)
        
        guard numberOfRows > 0 else { return }
        let indexPath = IndexPath(row: numberOfRows - 1, section: 0)
        logTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}
extension LoggerViewController: ListDestinationDelegate {
    func didReceive(_ message: String) {
        DispatchQueue.main.async {
            self.onLogMessageReceived(message)
        }
    }
}

extension LoggerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if let cell = cell as? LogTableCell {
            cell.configure(with: logMessages[indexPath.row])
        }
        return cell
    }
}
