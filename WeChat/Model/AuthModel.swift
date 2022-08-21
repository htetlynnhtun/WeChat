//
//  AuthModel.swift
//  WeChat
//
//  Created by kira on 15/08/2022.
//

import Foundation

protocol AuthModel {
    /// Check whether a user is already existed with the phone number.
    /// If a user exists, return an error message.
    /// If a user not exist, return Result.true
    func getOTP(phone: String, completion: @escaping (Result<Bool, OTPError>) -> Void)
    func verifyOTP(otp: String, completion: @escaping (Bool) -> Void)
    func signUp(phone: String, name: String, dob: Date, gender: String, password: String, completion: @escaping (UserVO?) -> Void)
    func login(phone: String, password: String, completion: @escaping (Result<UserVO, LoginError>) -> Void)
}

class AuthModelImpl: AuthModel {
    
    static let shared = AuthModelImpl()
    private init() { }
    
    private let authManager: AuthManager = FirebaseAuthManagerImpl()
   
    func getOTP(phone: String, completion: @escaping (Result<Bool, OTPError>) -> Void) {
        authManager.getOTP(phone: phone, completion: completion)
    }
    
    func verifyOTP(otp: String, completion: @escaping (Bool) -> Void) {
        authManager.verifyOTP(otp: otp, completion: completion)
    }
    
    func signUp(phone: String, name: String, dob: Date, gender: String, password: String, completion: @escaping (UserVO?) -> Void) {
        authManager.signUp(phone: phone, name: name, dob: dob, gender: gender, password: password, completion: completion)
    }
    
    func login(phone: String, password: String, completion: @escaping (Result<UserVO, LoginError>) -> Void) {
        authManager.login(phone: phone, password: password, completion: completion)
    }
    
}
