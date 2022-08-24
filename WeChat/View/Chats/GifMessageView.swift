//
//  GifMessageView.swift
//  WeChat
//
//  Created by kira on 24/08/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct GifMessageView: View {
    @EnvironmentObject var chatVM: ChatViewModel
    
    var message: MessageVO
    
    var body: some View {
        VStack(alignment: chatVM.isInComing(message) ? .leading : .trailing, spacing: 8) {
            AnimatedImage(url: URL(string: message.payload))
                .resizable()
                .scaledToFit()
                .frame(height: 128)
                .cornerRadius(5)
            
            Text(message.timestamp.toReadable())
                .font(.system(size: 8))
                .foregroundColor(.colorPrimary)
        }
    }
}

//struct GifMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        GifMessageView()
//    }
//}
