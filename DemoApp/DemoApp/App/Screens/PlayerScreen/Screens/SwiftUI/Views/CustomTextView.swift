//
//  CustomTextView.swift
//  HostApp
//
//  Created by Aleksander Eliseev on 28/01/2024.
//

import SwiftUI

struct CustomTextView: View {
    
    let text: String
    let size: CGFloat
    let weight: Font.Weight
    
    var body: some View {
        Text(text)
            .frame(alignment: .leading)
            .font(.system(size: size, weight: weight))
    }
}

#Preview {
    CustomTextView(text: "Hello", size: 20, weight: .semibold)
}
