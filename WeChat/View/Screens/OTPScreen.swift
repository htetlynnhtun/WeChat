//
//  OTPScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct OTPScreen: View {
    @State private var phoneNumberValue = ""
    @State private var code1 = ""
    @State private var code2 = ""
    @State private var code3 = ""
    @State private var code4 = ""
    @State private var otpCode = ""
    
    var body: some View {
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
                    MaterialTextField(placeholder: "Enter Your Phone Number", text: $phoneNumberValue)
                        .keyboardType(.phonePad)
                    
                    Button("Get OTP") {
                        print("ontap get otp")
                    }
                    .frame(width: 90, height: 40)
                    .wcPrimaryButton()
                }
                
                // TODO: Refactor me
//                HStack(spacing: 20) {
//                    ZStack {
//                        Rectangle()
//
//                            .foregroundColor(.white)
//                            .shadow(color: .colorOTPShadow, radius: 2, x: 0, y: 5)
//
//                        VStack {
//                            TextField("", text: $code1)
//                                .multilineTextAlignment(.center)
//                                .keyboardType(.decimalPad)
//
//                            Divider()
//                                .frame(height: 1)
//                                .background(Color.colorPrimary)
//                                .padding(.horizontal, 8)
//                        }
//
//                    }
//                    .frame(width: 41, height: 45)
//
//                    ZStack {
//                        Rectangle()
//
//                            .foregroundColor(.white)
//                            .shadow(color: .colorOTPShadow, radius: 2, x: 0, y: 5)
//
//                        VStack {
//                            TextField("", text: $code2)
//                                .multilineTextAlignment(.center)
//                                .keyboardType(.decimalPad)
//
//                            Divider()
//                                .frame(height: 1)
//                                .background(Color.colorPrimary)
//                                .padding(.horizontal, 8)
//                        }
//
//                    }
//                    .frame(width: 41, height: 45)
//
//                    ZStack {
//                        Rectangle()
//
//                            .foregroundColor(.white)
//                            .shadow(color: .colorOTPShadow, radius: 2, x: 0, y: 5)
//
//                        VStack {
//                            TextField("", text: $code3)
//                                .multilineTextAlignment(.center)
//                                .keyboardType(.decimalPad)
//
//                            Divider()
//                                .frame(height: 1)
//                                .background(Color.colorPrimary)
//                                .padding(.horizontal, 8)
//                        }
//
//                    }
//                    .frame(width: 41, height: 45)
//
//                    ZStack {
//                        Rectangle()
//
//                            .foregroundColor(.white)
//                            .shadow(color: .colorOTPShadow, radius: 2, x: 0, y: 5)
//
//                        VStack {
//                            TextField("", text: $code4)
//                                .multilineTextAlignment(.center)
//                                .keyboardType(.decimalPad)
//
//                            Divider()
//                                .frame(height: 1)
//                                .background(Color.colorPrimary)
//                                .padding(.horizontal, 8)
//                        }
//
//                    }
//                    .frame(width: 41, height: 45)
//                }
                
                OTPInputView(otpCode: $otpCode)
                
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
                
            }
            .frame(width: 132, height: 48)
            .wcPrimaryButton()
        }
        .padding([.horizontal, .top], 32)
        .padding(.bottom, 8)
        .onChange(of: otpCode) { newValue in
            print(newValue)
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
