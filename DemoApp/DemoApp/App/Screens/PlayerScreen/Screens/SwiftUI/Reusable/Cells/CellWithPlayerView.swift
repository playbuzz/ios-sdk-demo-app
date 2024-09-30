//
//  CellWithPlayerView.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 29/09/2024.
//

import SwiftUI
import MobileSDK

struct CellWithPlayerView: View {
    let configuration: ExcoPlayerConfiguration
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            ExcoPlayerSUIView(reusableConfiguration: configuration)
                .reusable()
                .aspectRatio(PlayerSwiftUIScreen.Constants.aspectRatio, contentMode: .fit)
                .padding(.bottom, PlayerSwiftUIScreen.Constants.mainStackSpacing)
            CellWithTitleAndSubtitleOnly(title: title, subtitle: subtitle)
        }
    }
}
