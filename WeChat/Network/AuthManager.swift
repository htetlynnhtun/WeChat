//
//  AuthManager.swift
//  WeChat
//
//  Created by kira on 15/08/2022.
//

import Foundation

protocol AuthManager {
    /// Check whether a user is already existed with the phone number.
    /// If a user exists, return an error message.
    /// If a user not exist, return Result.true
    func getOTP(phone: String, completion: @escaping (Result<Bool, OTPError>) -> Void)
    func verifyOTP(otp: String, completion: @escaping (Bool) -> Void)
    func signUp(phone: String, name: String, dob: Date, gender: String, password: String, completion: @escaping (UserVO?) -> Void)
    func login(phone: String, password: String, completion: @escaping (Result<UserVO, LoginError>) -> Void)
}

enum LoginError: Error {
    case invalid
    case unexpected
    
    var message: String {
        switch self {
        case .invalid:
            return "Inavlid phone number or password"
        case .unexpected:
            return "Something went wrong"
        }
    }
}

enum OTPError: Error {
    case userExist
    case unexpected
    
    var message: String {
        switch self {
        case .userExist:
            return "A user already exist with that phone number"
        case .unexpected:
            return "Something went wrong"
        }
    }
}
