//
//  ChatThreadScreen.swift
//  WeChat
//
//  Created by kira on 20/07/2022.
//

import SwiftUI
import Introspect
import Photos

struct ChatThreadScreen: View {
    @EnvironmentObject var mockData: MockDataViewModel
    @State private var anyTabBarController: UITabBarController?
    @State private var textFieldValue = ""
    @State private var isShowingPhotoPicker = false
    @State private var isShowingCamera = false
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(mockData.messages, id: \.self) { value in
                    MessageItemView(message: value)
                        .listRowSeparator(.hidden)
                }
                .upsideDown()
            }
            .padding(.horizontal, 16)
            .upsideDown()
            
            HStack {
                TextField("", text: $textFieldValue)
                    .placeholder(when: textFieldValue.isEmpty) {
                        Text("Type a message...")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                
                Button {
                    // Need to track type of message payload
                    /*
                     Payload can be:
                        - text
                        - image
                        - video
                        - gif
                        - location
                        - voice message
                     */
                    print("sending message")
                } label: {
                    Image(systemName: "paperplane")
                        .rotationEffect(Angle(degrees: 45))
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.colorPrimary)
                        .clipShape(Circle())
                    
                }
                
            }
            .padding(.horizontal)
            
            HStack(spacing: 30) {
                MessageActionView {
                    Image(systemName: "photo")
                        .font(.system(size: 24))
                        .padding(8)
                } action: {
                    print("Choosing photo")
                    isShowingPhotoPicker.toggle()
                }
                
                MessageActionView {
                    Image(systemName: "camera")
                        .font(.system(size: 24))
                        .padding(8)
                } action: {
                    print("Taking photo")
                    isShowingCamera = true
                    /*
                     - let user take photo
                     - user tap send
                     - get pngData
                     - upload to firebase
                     */
                    
                    
                }
                
                MessageActionView {
                    Image("gif-icon")
                        .padding(8)
                } action: {
                    print("Choosing GIF")
                }
                
                MessageActionView {
                    Image(systemName: "location")
                        .font(.system(size: 24))
                        .padding(8)
                } action: {
                    print("sending location")
                }
                
                MessageActionView {
                    Image(systemName: "mic")
                        .font(.system(size: 24))
                        .padding(8)
                } action: {
                    print("Sending voice message")
                }
            }
            .frame(maxWidth: .infinity, minHeight: 70)
            .padding(.bottom)
            .background {
                Color.white
                    .shadow(color: .gray.opacity(0.5), radius: 6, x: 0, y: 2)
            }
            
            if (isShowingPhotoPicker) {
                ChatImagePicker()
                    .frame(height: 300)
                    .padding(.horizontal, 16)
            }
        }
        .ignoresSafeArea(.container, edges: [.bottom])
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    ChatHeadItemView(
                        isActive: true,
                        size: 40
                    )
                    
                    VStack(alignment: .leading) {
                        Text("Ace")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                        
                        Text("Online")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.colorPrimary)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(Angle(degrees: 90))
                }
            }
        }
        .fullScreenCover(isPresented: $isShowingCamera, content: {
            WCCameraScreen()
        })
        .introspectTabBarController { tabBarController in
            tabBarController.tabBar.isHidden = true
            anyTabBarController = tabBarController
        }
        .onDisappear {
            anyTabBarController?.tabBar.isHidden = false
        }
        
    }
}

struct ChatThreadScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatThreadScreen()
                .environmentObject(MockDataViewModel())
        }
        .previewInterfaceOrientation(.portrait)
    }
}





