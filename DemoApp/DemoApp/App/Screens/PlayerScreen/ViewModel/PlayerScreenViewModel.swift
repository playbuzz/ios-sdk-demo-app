//
//  PlayerSuiViewModel.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 28/01/2024.
//

import Foundation
import MobileSDK

protocol PlayerScreenViewModelProtocol: ObservableObject {
    var playerConfiguration: ExcoPlayerConfiguration { get }
    var title: String { get }
    var subtitle: String { get }
}

final class PlayerScreenViewModel {

    let playerConfiguration: ExcoPlayerConfiguration
    
    // MARK: Init
    init(configuration: ExcoPlayerConfiguration) {
        self.playerConfiguration = configuration
    }
}

// MARK: PlayerScreenViewModelProtocol
extension PlayerScreenViewModel: PlayerScreenViewModelProtocol {
    var title: String {
        return "Lorem ipsum dolor sit amet consectetur."
    }
    
    var subtitle: String {
        var content = """
Lorem ipsum dolor sit amet consectetur. Gravida est adipiscing ipsum sit luctus sollicitudin quam dui quis. Arcu volutpat elementum et varius ut eget libero ac. Ornare senectus vitae id metus elementum et. 
"""
        for _ in 0...3 {
            content += content
        }
        return content
    }
}
