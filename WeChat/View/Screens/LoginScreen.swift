//
//  LoginScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct LoginScreen: View {
    
    @State private var phoneNumberValue = ""
    @State private var passwordValue = ""
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Welcome!")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.colorPrimary)
                    
                    Text("Login to continue")
                        .font(.system(size: 16))
                        .foregroundColor(.colorPrimaryVariant)
                }
                
                Spacer()
            }
            
            Spacer()
            
            Image("Mobile-login-1")
                .resizable()
                .frame(width: 268.38, height: 200)
            
            Spacer()
            
            VStack(spacing: 40) {
                MaterialTextField(placeholder: "Enter Your Phone Number", text: $phoneNumberValue)
                    .keyboardType(.phonePad)
                
                MaterialTextField(placeholder: "Enter Your Password", isSecured: true, text: $passwordValue)
            }
            .padding(.bottom)
            
            HStack {
                Spacer()
                Text("Forgot Password?")
                    .font(.system(size: 14))
                .foregroundColor(.colorPrimary)
            }
            
            Spacer()
            
            Button("Login") {
                print("Login is tapped")
            }
            .frame(width: 132, height: 48)
            .wcPrimaryButton()
            
        }
        .padding([.horizontal, .top], 32)
        .padding(.bottom, 8)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max", "iPhone SE (3rd generation)"], id: \.self) { deviceName in
            LoginScreen()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .previewInterfaceOrientation(.portrait)
        
    }
}
