//
//  ListDestination.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 28/11/2023.
//
import Foundation
import XCGLogger

protocol ListDestinationDelegate : AnyObject
{
    func didRecive(_ message: String)
}
///
///
///
class ListDestination : BaseQueuedDestination {
    
    weak var delegate : ListDestinationDelegate?
    
    open override func write(message: String) {
        
        let outputClosure : () -> Void = { [weak self] in
            self?.delegate?.didRecive(message)
        }
        
        if let logQueue {
            logQueue.async(execute: DispatchWorkItem(block: outputClosure))
        } else {
            outputClosure()
        }
    }
}
