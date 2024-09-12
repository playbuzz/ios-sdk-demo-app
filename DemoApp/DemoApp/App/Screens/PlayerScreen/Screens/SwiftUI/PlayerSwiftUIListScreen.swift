//
//  PlayerSwiftUIListScreen.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 28/01/2024.
//

import SwiftUI
import MobileSDK

struct PlayerSwiftUIListScreen: View {
    
    @State var viewModel: any PlayerScreenViewModelProtocol
    @State private var showList = true
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        showList = true
                    }) {
                        Text("Show List")
                            .padding()
                            .background(showList ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        showList = false
                    }) {
                        Text("Show ScrollView")
                            .padding()
                            .background(!showList ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.top, 20)
                
                if showList {
                    ListSection(viewModel: viewModel)
                } else {
                    ScrollViewSection(viewModel: viewModel)
                }
            }
        }
    }
}

private struct ListSection: View {
    let viewModel: any PlayerScreenViewModelProtocol
    
    var body: some View {
        VStack {
            List(0..<8) { index in
                if [1, 3].contains(index) {
                    let configuration = viewModel.playerConfigurations[index]
                    CellWithPlayerView(configuration: configuration,
                                       title: configuration.playerID,
                                       subtitle: viewModel.subtitle)
                } else {
                    CellWithTitleAndSubtitleOnly(title: viewModel.title,
                                                 subtitle: viewModel.subtitle)
                }
            }
        }
    }
}

private struct ScrollViewSection: View {
    let viewModel: any PlayerScreenViewModelProtocol
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(0..<8, id: \.self) { index in
                        if [2, 4].contains(index) {
                            let configuration = viewModel.playerConfigurations[index]
                            CellWithPlayerView(configuration: configuration,
                                               title: configuration.playerID,
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

private struct CellWithTitleAndSubtitleOnly: View {
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

private struct CellWithPlayerView: View {
    let configuration: ExcoPlayerConfiguration
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
//            ExcoPlayerSUIView(reusableConfiguration: configuration)
//                .modifier(ExcoPlayerSUReusableModifier(configuration: configuration))
//                .aspectRatio(PlayerSwiftUIScreen.Constants.aspectRatio, contentMode: .fit)
//                .padding(.bottom, PlayerSwiftUIScreen.Constants.mainStackSpacing)
            CellWithTitleAndSubtitleOnly(title: title, subtitle: subtitle)
        }
    }
}

#Preview {
    let config = ExcoMobileSDK.builder(with: Constants.PlayerIdConstants.playerIdWithAds).build()
    return PlayerSwiftUIScreen(
        viewModel: PlayerScreenViewModel(
            configurations: [config])
    )
}
