//
//  ListSection.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 29/09/2024.
//

import SwiftUI

struct ListSection: View {
    let viewModel: any PlayerScreenViewModelProtocol
    
    var body: some View {
        VStack {
            List(0..<8) { index in
                if [1, 3].contains(index) {
                    CellWithPlayerView(configuration: viewModel.playerConfiguration,
                                       title: viewModel.playerConfiguration.playerID,
                                       subtitle: viewModel.subtitle)
                } else {
                    CellWithTitleAndSubtitleOnly(title: viewModel.title,
                                                 subtitle: viewModel.subtitle)
                }
            }
        }
    }
}
