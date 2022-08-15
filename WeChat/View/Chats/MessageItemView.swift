//
//  MessageItemView.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import SwiftUI
import CachedAsyncImage

struct MessageItemView: View {
    var message: MessageVO
    var currentUser = "John"
    
    private var isInComing: Bool {
        message.sender != currentUser
    }
    
    private var backgroundColor: Color {
        isInComing ? Color.colorGray2.opacity(0.5): .colorPrimary
    }
    
    var body: some View {
        HStack {
            if (isInComing) {
                VStack {
                    ChatHeadItemView(isActive: true, size: 30)
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
                    ImageMessageView(message: message)
                    
                case .audio:
                    VoiceMessageView(vm: VoiceMessageViewModel(message: message))
                default:
                    EmptyView()
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background {
                if (message.type == .text || message.type == .audio) {
                    backgroundColor
                } else {
                    EmptyView()
                }
            }
            .cornerRadius(5)
            
            if (isInComing) {
                Spacer()
            }
        }
        .frame(minHeight: 46)
    }
}

struct MessageItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageItemView(message: MockDataViewModel().messages[0])
            MessageItemView(message: MockDataViewModel().messages[1])
            MessageItemView(message: MockDataViewModel().messages[2])
        }
    }
}
