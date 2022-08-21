//
//  HomeVIew.swift
//  WeChat
//
//  Created by kira on 21/08/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var currentTab = Tab.moment
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        TabView(selection: $currentTab) {
            MomentScreen()
                .tabItem {
                    Label {
                        Text("Moment")
                    } icon: {
                        Image("moment-icon")
                            .renderingMode(.template)
                    }
                }
                .tag(Tab.moment)
            
            ChatScreen()
                .tabItem {
                    Label {
                        Text("Chat")
                    } icon: {
                        Image("chat-icon")
                            .renderingMode(.template)
                    }
                }
                .tag(Tab.chat)
                .environmentObject(ChatHistoryViewModel(qrCode: authVM.currentUser.qrCode))
            
            ContactsScreen()
                .tabItem {
                    Label {
                        Text("Contacts")
                    } icon: {
                        Image("contacts-icon")
                            .renderingMode(.template)
                    }
                }
                .tag(Tab.contacts)
            
            MeScreen()
                .tabItem {
                    Label {
                        Text("Me")
                    } icon: {
                        Image("me-icon")
                            .renderingMode(.template)
                    }
                }
                .tag(Tab.me)
                .environmentObject(MeViewModel(user: authVM.currentUser))
            
            SettingScreen()
                .tabItem {
                    Label {
                        Text("Setting")
                    } icon: {
                        Image("setting-icon")
                            .renderingMode(.template)
                    }
                }
        }    }
}

struct HomeVIew_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
