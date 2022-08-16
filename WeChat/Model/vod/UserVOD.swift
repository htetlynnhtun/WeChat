//
//  UserVO.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import Foundation

struct UserVOD: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var avatar: String
    var favorites: [Int]
    var contacts: [Int]
}
