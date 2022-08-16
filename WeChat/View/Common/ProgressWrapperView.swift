//
//  ProgressWrapperView.swift
//  WeChat
//
//  Created by kira on 15/08/2022.
//

import SwiftUI

struct ProgressWrapperView<Content>: View where Content: View {
    
    let child: Content
    var showActivityIndicator: Bool
    
    init(showActivityIndicator: Bool, @ViewBuilder content: () -> Content) {
        self.showActivityIndicator = showActivityIndicator
        child = content()
    }
    
    var body: some View {
        ZStack {
            child
            
            if (showActivityIndicator) {
                Group {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea(.all, edges: .all)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .colorWCGreen))
                        .scaleEffect(3)
                }
            }
        }
    }
}
