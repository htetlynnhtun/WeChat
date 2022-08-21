//
//  AuthViewModel.swift
//  WeChat
//
//  Created by kira on 15/08/2022.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    private let authModel: AuthModel = AuthModelImpl.shared
    private let credentialsRepo: CredentialsRepository = CredentialsRepositoryJSONImpl.shared
    
    @Published var currentUser: UserVO = .dummy()
    @Published var phoneNumberValue = ""
    @Published var userSubmittedOTP = ""
    @Published var nameValue = ""
    @Published var dobValue = Date.now
    @Published var genderValue = Gender.male
    @Published var passwordValue = ""
    @Published var checkBoxValue = false
    
    
    @Published var toastMessage = ""
    @Published var isShowingToast = false
    @Published var showActivityIndicator = false
    @Published var shouldNavigateToRegisterScreen = false
    @Published var shouldNavigateToLoginScreen = false
    
    init() {
        credentialsRepo.getCredentials { [weak self] userVO in
            self?.currentUser = userVO ?? .dummy()
        }
    }
    
    func onTapGetOTP() {
        guard phoneNumberValue.isNotEmpty else {
            return
        }
        
        showActivityIndicator = true
        authModel.getOTP(phone: phoneNumberValue) { [weak self] result in
            self?.showActivityIndicator = false
            
            switch result {
            case .success(_):
                self?.toastMessage = "A code was sent to your phone"
            case .failure(let error):
                self?.toastMessage = error.message
            }
            self?.isShowingToast = true
        }
    }
    
    func onTapVerifyOTP() {
        showActivityIndicator = true
        authModel.verifyOTP(otp: userSubmittedOTP) { [weak self] status in
            self?.showActivityIndicator = false
            
            if (status) {
                self?.shouldNavigateToRegisterScreen = true
            } else {
                self?.toastMessage = "OTP verification failed"
            }
            self?.isShowingToast = true
        }
    }
    
    func onTapSignUp() {
        guard nameValue.isNotEmpty,
              passwordValue.isNotEmpty,
              checkBoxValue == true else {
            return
        }
        
        var genderString = ""
        switch genderValue {
        case .male:
            genderString = "Male"
        case .female:
            genderString = "Female"
        case .other:
            genderString = "Other"
        }
        
        showActivityIndicator = true
        authModel.signUp(phone: phoneNumberValue, name: nameValue, dob: dobValue, gender: genderString, password: passwordValue) { [weak self] user in
            self?.showActivityIndicator = false
            
            if let user = user {
                self?.shouldNavigateToLoginScreen = true
                self?.nameValue = ""
                self?.phoneNumberValue = ""
                self?.passwordValue = ""
                self?.credentialsRepo.saveCredentials(vo: user, completion: {
                    self?.currentUser = user
                })
            } else {
                self?.toastMessage = "Failed to register"
                self?.isShowingToast = true
            }
        }
    }
    
    func onTapLogin() {
        guard phoneNumberValue.isNotEmpty,
              passwordValue.isNotEmpty else {
            return
        }
        
        showActivityIndicator = true
        authModel.login(phone: phoneNumberValue, password: passwordValue) { [weak self] result in
            self?.showActivityIndicator = false
            
            switch result {
            case .success(let userVO):
                self?.credentialsRepo.saveCredentials(vo: userVO) { [weak self] in
                    self?.currentUser = userVO
                }
                
            case .failure(let error):
                self?.toastMessage = error.message
                self?.isShowingToast = true
            }
        }
    }
    
    func onTapLogout() {
        credentialsRepo.clearCredentials { [weak self] in
            self?.resetAllState()
        }
    }
    
    private func resetAllState() {
        currentUser = .dummy()
        phoneNumberValue = ""
        userSubmittedOTP = ""
        nameValue = ""
        dobValue = Date.now
        genderValue = Gender.male
        passwordValue = ""
        checkBoxValue = false
        
        
        toastMessage = ""
        isShowingToast = false
        showActivityIndicator = false
        shouldNavigateToRegisterScreen = false
        shouldNavigateToLoginScreen = false
    }
    
}

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
