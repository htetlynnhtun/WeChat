//
//  ChatItemView.swift
//  WeChat
//
//  Created by kira on 19/07/2022.
//

import SwiftUI

struct ChatItemView: View {
    var username: String
    var indicator: ChatItemIndicator = .none
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(10)
                .frame(height: 62)
                .foregroundColor(.white)
                .shadow(color: .colorChatItemShadow, radius: 1, x: 0, y: 1)
            
            HStack {
                ChatHeadItemView(isActive: true)
                
                VStack(alignment: .leading) {
                    Text(username)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .foregroundColor(.colorPrimary)
                    
                    Spacer()
                    
                    Text("You sent a video")
                        .font(.system(size: 14))
                        .foregroundColor(.colorGray)
                }
                
                Spacer()
                
                VStack {
                    Text("5min")
                        .font(.system(size: 12))
                        .foregroundColor(.colorPrimary)
                    
                    Spacer()
                    
                    switch indicator {
                    case .seen:
                        Image("seen-icon")
                            .frame(height: 15)
                    case .sent:
                        Image("sent-icon")
                            .frame(height: 15)
                    case .notiOff:
                        Image("noti-off-icon")
                            .frame(height: 15)
                    case .none:
                        Spacer()
                    }
                    
                }
            }
            .padding(15)
            
        }
        .frame(height: 62)
    }
}
        
enum ChatItemIndicator: CaseIterable {
    case seen
    case sent
    case notiOff
    case none
}


struct ChatItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ChatItemView(
                username: "Min Thant Kyaw",
                indicator: .seen
            )
            ChatItemView(
                username: "ATF and Brothers",
                indicator: .none
            )
            ChatItemView(
                username: "Mary",
                indicator: .sent
            )
            ChatItemView(
                username: "James",
                indicator: .notiOff
            )
        }
    }
}
