//
//  UserVO.swift
//  WeChat
//
//  Created by kira on 15/08/2022.
//

import Foundation

struct UserVO: Codable {
    var phoneNumber: String
    var name: String
    var dob: String
    var gender: String
    var profilePicture: String
    var qrCode: String
    var password: String
}
