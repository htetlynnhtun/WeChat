//
//  OTPScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct OTPScreen: View {
    @EnvironmentObject var authVM: AuthViewModel
    @FocusState private var isFocused
    
    var body: some View {
        ProgressWrapperView(showActivityIndicator: authVM.showActivityIndicator) {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Hi!")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.colorPrimary)
                        
                        Text("Create a new account.")
                            .font(.system(size: 16))
                            .foregroundColor(.colorPrimaryVariant)
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                Image("Otp")
                
                Spacer()
                
                VStack(spacing: 35) {
                    HStack {
                        MaterialTextField(placeholder: "Enter Your Phone Number", text: $authVM.phoneNumberValue)
                            .focused($isFocused)
                            .keyboardType(.phonePad)
                        
                        Button("Get OTP") {
                            isFocused = false
                            authVM.onTapGetOTP()
                        }
                        .frame(width: 90, height: 40)
                        .wcPrimaryButton()
                    }
                    
                    OTPInputView(otpCode: $authVM.userSubmittedOTP)
                    
                    HStack {
                        Text("Dont receive the OTP?")
                            .foregroundColor(.colorGray)
                        
                        Text("Resend code")
                            .fontWeight(.bold)
                            .foregroundColor(.colorPrimary)
                    }
                    .font(.system(size: 14))
                }
                
                Spacer()
                
                Button("Verify") {
                    authVM.onTapVerifyOTP()
                }
                .frame(width: 132, height: 48)
                .wcPrimaryButton()
                
                // MARK: - Naviagation
                NavigationLink(isActive: $authVM.shouldNavigateToRegisterScreen) {
                    RegisterScreen()
                } label: {
                    EmptyView()
                }
                
            }
            .padding([.horizontal, .top], 32)
            .padding(.bottom, 8)
            .toast(message: authVM.toastMessage, isShowing: $authVM.isShowingToast, duration: Toast.short)
        }
    }
}

struct OTPScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max", "iPhone SE (3rd generation)"], id: \.self) { deviceName in
            OTPScreen()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
