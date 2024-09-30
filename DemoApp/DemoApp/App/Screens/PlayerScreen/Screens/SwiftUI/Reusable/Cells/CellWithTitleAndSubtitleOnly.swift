//
//  CellWithTitleAndSubtitleOnly.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 29/09/2024.
//

import SwiftUI

struct CellWithTitleAndSubtitleOnly: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomTextView(text: title,
                           size: PlayerSwiftUIScreen.Constants.titleTextSize,
                           weight: .semibold)
            .padding(.bottom, PlayerSwiftUIScreen.Constants.mainStackSpacing)
            CustomTextView(text: subtitle,
                           size: PlayerSwiftUIScreen.Constants.subtitleTextSize,
                           weight: .regular)
            .padding(.bottom, PlayerSwiftUIScreen.Constants.mainStackSpacing)
        }
        .frame(maxHeight: 350)
    }
}
