//
//  ChatScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct ChatScreen: View {
    @EnvironmentObject var chatHistoryVM: ChatHistoryViewModel
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Active Now")
                        .font(.system(size: 14))
                        .foregroundColor(.colorPrimaryVariant)
                        .padding(.leading)
                    
                    ActivePeopleView()
                    
                    ForEach(chatHistoryVM.messages, id: \.id) { message in
                        NavigationLink {
                            ChatThreadScreen(chatVM: ChatViewModel(sender: authVM.currentUser,
                                                                   receiver: chatHistoryVM.receiver(for: message),
                                                                   receiverName: chatHistoryVM.username(for: message),
                                                                   receiverProfilePicture: chatHistoryVM.profileLink(for: message),
                                                                   groupID: message.groupID,
                                                                   groupName: message.groupName,
                                                                   groupPicture: message.groupPicture))
                        } label: {
                            ChatItemView(message: message, indicator: .allCases.randomElement()!)
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
        .onAppear {
            chatHistoryVM.fetchLatestMessages()
        }
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen()
    }
}

struct ActivePeopleView: View {
    @EnvironmentObject var contactVM: ContactViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(contactVM.originalContacts, id: \.qrCode) { user in
                    VStack {
                        ChatHeadItemView(isActive: true, avatar: user.profilePicture)
                        
                        Text(user.name)
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
        .onAppear {
            if (contactVM.originalContacts.isEmpty) {
                contactVM.fetchContacts()
            }
        }
    }
}
