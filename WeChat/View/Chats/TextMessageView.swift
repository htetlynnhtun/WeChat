//
//  TextMessageView.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import SwiftUI

struct TextMessageView: View {
    var currentUser = "John"
    var message: MessageVO
    
    private var isIncoming: Bool {
        return currentUser != message.sender
    }
    
    var body: some View {
        VStack(alignment: isIncoming ? .leading : .trailing, spacing: 8) {
            Text(message.payload)
                .font(.system(size: 16))
                .foregroundColor(isIncoming ? .colorPrimary : .white)
            
            Text(message.date)
                .font(.system(size: 8))
                .foregroundColor(isIncoming ? .colorGray: .white)
        }
    }
}

struct TextMessageView_Previews: PreviewProvider {
    static var previews: some View {
        TextMessageView(message: MockDataViewModel().messages[0])
    }
}
