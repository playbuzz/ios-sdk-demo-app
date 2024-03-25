//
//  PlayerSwiftUIScreen.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 28/01/2024.
//

import SwiftUI
import MobileSDK

struct PlayerSwiftUIScreen: View {
    
    @State var viewModel: any PlayerScreenViewModelProtocol
        
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                ExcoPlayerSUIView(configuration: viewModel.playerConfiguration, shouldStoreInCache: false)
                    .aspectRatio(Constants.aspectRatio, contentMode: .fit)
                    .padding(.bottom, Constants.mainStackSpacing)
                VStack(alignment: .leading) {
                    CustomTextView(text: viewModel.title,
                                   size: Constants.titleTextSize,
                                   weight: .semibold)
                    .padding(.bottom, Constants.mainStackSpacing)
                    CustomTextView(text: viewModel.subtitle,
                                   size: Constants.subtitleTextSize,
                                   weight: .regular)
                    .padding(.bottom, Constants.mainStackSpacing)
                }
            }
        }
        .padding([.top, .leading, .trailing], Constants.sidePadding)
    }
}

// MARK: Constants
private extension PlayerSwiftUIScreen {
    struct Constants {
        static let aspectRatio: CGFloat = 16.0 / 9.0
        static let sidePadding: CGFloat = 16.0
        static let titleTextSize: CGFloat = 20.0
        static let subtitleTextSize: CGFloat = 17.0
        static let mainStackSpacing: CGFloat = 20.0
    }
}

#Preview {
    let config = ExcoMobileSDK.builder(with: Constants.PlayerIdConstants.playerIdWithAds).build()
    return PlayerSwiftUIScreen(
        viewModel: PlayerScreenViewModel(
            configuration: config)
    )
}
