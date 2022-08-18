//
//  ImageMessageView.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import SwiftUI
import CachedAsyncImage

struct ImageMessageView: View {
    var currentUser = "John"
    var message: MessageVOD
    
    private var isIncoming: Bool {
        return currentUser != message.sender
    }
    
    var body: some View {
        VStack(alignment: isIncoming ? .leading : .trailing, spacing: 8) {
            CachedAsyncImage(url: URL(string: message.payload)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(height: 128)
            .cornerRadius(5)
            
            Text(message.date)
                .font(.system(size: 8))
                .foregroundColor(.colorPrimary)
        }
    }
}

struct ImageMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageMessageView(message: MockDataViewModel().messages[0])
    }
}
