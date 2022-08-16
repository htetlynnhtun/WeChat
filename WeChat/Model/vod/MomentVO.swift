//
//  MomentVO.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import Foundation

struct MomentVO: Codable, Identifiable, Hashable {
    var id: Int
    var authorProfile: String
    var authorName: String
    var description: String
}
