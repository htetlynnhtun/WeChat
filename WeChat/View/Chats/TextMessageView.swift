//
//  TextMessageView.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import SwiftUI

struct TextMessageView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var chatVM: ChatViewModel
    
    var message: MessageVO
    
    var body: some View {
        VStack(alignment: chatVM.isInComing(message) ? .leading : .trailing, spacing: 8) {
            Text(message.payload)
                .font(.system(size: 16))
                .foregroundColor(chatVM.isInComing(message) ? .colorPrimary : .white)
            
            Text(message.timestamp.toReadable())
                .font(.system(size: 8))
                .foregroundColor(chatVM.isInComing(message) ? .colorGray: .white)
        }
    }
}

//struct TextMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextMessageView(message: MockDataViewModel().messages[0])
//    }
//}
