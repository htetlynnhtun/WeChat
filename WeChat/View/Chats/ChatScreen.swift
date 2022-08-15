//
//  ChatScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct ChatScreen: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Active Now")
                        .font(.system(size: 14))
                        .foregroundColor(.colorPrimaryVariant)
                        .padding(.leading)
                    
                    ActivePeopleView()
                    
                    ForEach(0..<20) { i in
                        NavigationLink {
                            ChatThreadScreen()
                        } label: {
                            ChatItemView(username: "User \(i)", indicator: .allCases.randomElement()!)
                                .padding(.bottom, 6)
                                .padding(.horizontal, 8)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Chats")
                        .screenTitle()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("search-icon")
                }
            }
        }
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen()
    }
}

struct ActivePeopleView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<10) { _ in
                    VStack {
                        ChatHeadItemView(isActive: true)
                        
                        Text("George")
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 12))
                            .foregroundColor(.colorPrimary)
                    }
                    .frame(width: 60)
                }
            }.padding(.horizontal)
        }
    }
}
