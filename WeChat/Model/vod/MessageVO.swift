//
//  MessageVO.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import Foundation

struct MessageVO: Codable, Hashable, Identifiable {
    var id: Int
    var type: MessagePayloadType
    var payload: String
    var sender: String
    var receiver: String
    var date: String
    
    enum MessagePayloadType: String, Codable {
        case text = "text"
        case image = "image"
        case video = "video"
        case audio = "audio"
    }
}
