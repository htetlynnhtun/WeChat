//
//  MessageActionView.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI

struct MessageActionView<Content>: View where Content: View {
    var content: () -> Content
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 5)
            
            content()
                .foregroundColor(.colorPrimary)
        }
        .onTapGesture {
            action()
        }
    }
}
