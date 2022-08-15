//
//  SplashScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
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
                        print("Sign Up is tapped")
                    }
                    .frame(width: 132, height: 48)
                    .wcSecondaryButton()
                    
                    Button("Login") {
                        print("Login is tapped")
                    }
                    .frame(width: 132, height: 48)
                    .wcPrimaryButton()
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
