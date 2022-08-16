//
//  SplashScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct SplashScreen: View {
    @State private var shouldNavigateToLoginScreen = false
    @State private var shouldNavigateToOTPScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("Logo")
                
                Spacer()
                
                VStack(spacing: 32) {
                    VStack {
                        Text("Text your friends and share moments")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                        
                        Text("End-to-end secured messaging app with Social Elements")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.colorDarkBlue)
                    
                    HStack(spacing: 16) {
                        Button("Sign Up") {
                            shouldNavigateToOTPScreen = true
                        }
                        .frame(width: 132, height: 48)
                        .wcSecondaryButton()
                        
                        Button("Login") {
                            shouldNavigateToLoginScreen = true
                        }
                        .frame(width: 132, height: 48)
                        .wcPrimaryButton()
                    }
                }
                
                // MARK: - Navigation
                NavigationLink(isActive: $shouldNavigateToLoginScreen) {
                    LoginScreen()
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $shouldNavigateToOTPScreen) {
                    OTPScreen()
                } label: {
                    EmptyView()
                }


            }
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
