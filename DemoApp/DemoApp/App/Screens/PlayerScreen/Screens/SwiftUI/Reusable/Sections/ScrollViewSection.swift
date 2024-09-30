//
//  ScrollViewSection.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 29/09/2024.
//

import SwiftUI

struct ScrollViewSection: View {
    let viewModel: any PlayerScreenViewModelProtocol
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(0..<8, id: \.self) { index in
                        if [2, 4].contains(index) {
                            CellWithPlayerView(configuration: viewModel.playerConfiguration,
                                               title: viewModel.playerConfiguration.playerID,
                                               subtitle: viewModel.subtitle)
                            .padding()
                        } else {
                            CellWithTitleAndSubtitleOnly(title: viewModel.title,
                                                         subtitle: viewModel.subtitle)
                            .padding()
                        }
                    }
                }
            }
        }
    }
}
