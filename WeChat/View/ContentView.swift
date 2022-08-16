//
//  ContentView.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab = Tab.moment
    @StateObject var mockData = MockDataViewModel()
    
    @StateObject var authVM = AuthViewModel()
    @StateObject var momentVM = MomentViewModel()
    
    var body: some View {
        //        WCCameraScreen()
        //        SplashScreen()
        //                LoginScreen()
        //                OTPScreen()
        //                RegisterScreen()
        Group {
            if authVM.currentUser == nil {
                SplashScreen()
            } else {
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
                    
                    ContactsScreen(vm: ContactsViewModel(currentUser: mockData.currentUser))
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
                    
                    SettingScreen()
                        .tabItem {
                            Label {
                                Text("Setting")
                            } icon: {
                                Image("setting-icon")
                                    .renderingMode(.template)
                            }
                        }
                }
                .accentColor(.colorPrimary)
                .environmentObject(mockData)
                .environmentObject(momentVM)
            }

        }
        .environmentObject(authVM)
        
    }
}

enum Tab {
    case moment
    case chat
    case contacts
    case me
    case setting
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max", "iPhone SE (3rd generation)"], id: \.self) { deviceName in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

// Swipe back gesture - even back bar button is hidden
//extension UINavigationController: UIGestureRecognizerDelegate {
//    override open func viewDidLoad() {
//        super.viewDidLoad()
//        interactivePopGestureRecognizer?.delegate = self
//    }
//
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return viewControllers.count > 1
//    }
//}

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        //        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
