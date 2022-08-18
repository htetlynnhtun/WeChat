//
//  SelectedMemberItemView.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI

struct SelectedMemberItemView: View {
    var user: UserVO
    
    var body: some View {
        ZStack {
            VStack {
                ChatHeadItemView(isActive: true, size: 50, avatar: user.profilePicture)
                Text(user.name)
                    .font(.system(size: 8))
                    .foregroundColor(.colorPrimary)
            }
            .padding(4)
            .frame(height: 83)
            .background {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .shadow(color: .colorChatItemShadow.opacity(0.5), radius: 2, x: 1, y: 1)
            }
            
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 12))
                    .foregroundColor(.colorPrimary)
                    .padding(6)
                    .background {
                        Color.colorChatItemShadow
                    }
                    .clipShape(Circle())
            }
            .offset(x: 30, y: -42)
        }
    }
}

