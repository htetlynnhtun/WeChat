//
//  RegisterScreen.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import SwiftUI

struct RegisterScreen: View {
    @EnvironmentObject var authVM: AuthViewModel
    
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
                    .frame(height: 50)
                
                VStack(spacing: 40) {
                    MaterialTextField(placeholder: "Enter Your Name", text: $authVM.nameValue)
                    
                    
                    DatePicker("Date of Birth", selection: $authVM.dobValue, displayedComponents: .date)
                        .font(.system(size: 15))
                        .foregroundColor(.colorDarkBlue)
                    
                    VStack {
                        HStack {
                            Text ("Gender")
                                .font(.system(size: 15))
                                .foregroundColor(.colorDarkBlue)
                            
                            Spacer()
                        }
                        
                        Picker("Gender", selection: $authVM.genderValue) {
                            ForEach(Gender.allCases, id: \.rawValue) { gender in
                                Text(gender.rawValue)
                                    .tag(gender)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                    }
                    
                    MaterialTextField(placeholder: "Enter Your Password", isSecured: true, text: $authVM.passwordValue)
                    
                    HStack {
                        CheckBoxView(checked: $authVM.checkBoxValue)
                        
                        Text("Agree To ")
                            .foregroundColor(.colorGray)
                            .font(.system(size: 12))
                        +
                        Text("Term And Service")
                            .foregroundColor(.colorDarkBlue)
                            .font(.system(size: 12))
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                Button("Sign Up") {
                    authVM.onTapSignUp()
                }
                .frame(width: 132, height: 48)
                .wcPrimaryButton()
                
                // MARK: - Navigation
                NavigationLink(isActive: $authVM.shouldNavigateToLoginScreen) {
                    LoginScreen()
                } label: {
                    EmptyView()
                }
            }
            .padding([.horizontal, .top], 32)
            .padding(.bottom, 8)
            .overlay(alignment: .topTrailing) {
                Image("Half-circle")
            }
            .toast(message: authVM.toastMessage, isShowing: $authVM.isShowingToast, duration: Toast.short)
        }
    }
}

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max", "iPhone SE (3rd generation)"], id: \.self) { deviceName in
            RegisterScreen()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
