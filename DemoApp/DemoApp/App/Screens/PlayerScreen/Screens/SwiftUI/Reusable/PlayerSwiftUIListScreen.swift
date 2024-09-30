//
//  PlayerSwiftUIListScreen.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 29/09/2024.
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
                        makeButtonText("Show List")
                    }
                    
                    Button(action: {
                        showList = false
                    }) {
                        makeButtonText("Show ScrollView")
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ViewBuilder
    private func makeButtonText(_ text: String) -> some View {
        Text(text)
            .padding()
            .background(!showList ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
