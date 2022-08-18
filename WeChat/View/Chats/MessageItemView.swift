//
//  MessageItemView.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import SwiftUI
import CachedAsyncImage

struct MessageItemView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var chatVM: ChatViewModel
    
    var message: MessageVO
    
    
    var body: some View {
        HStack {
            if (chatVM.isInComing(message)) {
                VStack {
                    ChatHeadItemView(isActive: true, size: 30, avatar: chatVM.receiver.profilePicture)
                        .frame(width: 30, height: 40)
                    Spacer()
                }
            } else {
                Spacer()
            }
            
            Group {
                switch message.type {
                case .text:
                    TextMessageView(message: message)
                    
                case .image:
//                    ImageMessageView(message: message)
                    EmptyView()
                    
                case .audio:
//                    VoiceMessageView(vm: VoiceMessageViewModel(message: message))
                    EmptyView()
                default:
                    EmptyView()
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background {
                if (message.type == .text || message.type == .audio) {
                    chatVM.backgroundColor(for: message)
                } else {
                    EmptyView()
                }
            }
            .cornerRadius(5)
            .environmentObject(chatVM)
            
            if (chatVM.isInComing(message)) {
                Spacer()
            }
        }
        .frame(minHeight: 46)
    }
}

//struct MessageItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            MessageItemView(message: MockDataViewModel().messages[0])
//            MessageItemView(message: MockDataViewModel().messages[1])
//            MessageItemView(message: MockDataViewModel().messages[2])
//        }
//    }
//}
