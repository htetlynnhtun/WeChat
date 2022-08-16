//
//  UserVO.swift
//  WeChat
//
//  Created by kira on 15/08/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct UserVO: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var dob: String
    var gender: String
    var profilePicture: String
    var qrCode: String
    var password: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case dob
        case gender
        case profilePicture
        case qrCode
        case password
    }
}
