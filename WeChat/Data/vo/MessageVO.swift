//
//  MessageVO.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation
import FirebaseDatabase


struct MessageVO: Codable, Hashable, Identifiable {
    var id = UUID().uuidString
    var type: MessagePayloadType
    var payload: String
    var userID: String
    var userName: String
    var profilePicture: URL
    var rUserID: String
    var rUserName: String
    var rProfilePicture: URL
    var groupID: String?
    var groupName: String?
    var groupPicture: URL?
    var timestamp: Date
    
    enum MessagePayloadType: String, Codable {
        case text = "text"
        case image = "image"
        case gif = "gif"
        case video = "video"
        case audio = "audio"
    }
    
    init(id: String,
         type: MessagePayloadType,
         payload: String,
         userID: String,
         userName: String,
         profilePicture: URL,
         rUserID: String,
         rUserName: String,
         rProfilePicture: URL,
         timestamp: Date) {
        self.id = id
        self.type = type
        self.payload = payload
        self.userID = userID
        self.userName = userName
        self.profilePicture = profilePicture
        self.rUserID = rUserID
        self.rUserName = rUserName
        self.rProfilePicture = rProfilePicture
        self.timestamp = timestamp
    }
    
    init(from snapshot: DataSnapshot) {
        let value = snapshot.value as! [String: AnyObject]
        
        id = snapshot.key
        type =  MessagePayloadType(rawValue: value["type"] as! String)!
        payload = value["payload"] as! String
        userID = value["userID"] as! String
        userName = value["userName"] as! String
        profilePicture = URL(string: value["profilePicture"] as! String)!
        rUserID = value["rUserID"] as! String
        rUserName = value["rUserName"] as! String
        rProfilePicture = URL(string: value["rProfilePicture"] as! String)!
        timestamp = Date.create(from: value["timestamp"] as! String)
        
        groupID = value["groupID"] as? String
        groupName = value["groupName"] as? String
        if let gpPicture = value["groupPicture"] as? String {
            groupPicture = URL(string: gpPicture)!
        }
    }
    
    func toAny() -> Any {
        return [
            "type": type.rawValue,
            "payload": payload,
            "userID": userID,
            "userName": userName,
            "profilePicture": profilePicture.absoluteString,
            "rUserID": rUserID,
            "rUserName": rUserName,
            "rProfilePicture": rProfilePicture.absoluteString,
            "timestamp": timestamp.toString(),
            
            "groupID": groupID,
            "groupName": groupName,
            "groupPicture": groupPicture?.absoluteString,
        ]
    }
}

