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
    var timestamp: Date
    
    enum MessagePayloadType: String, Codable {
        case text = "text"
        case image = "image"
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
            "timestamp": timestamp.toString()
        ]
    }
}

extension Date {
    func toString() -> String {
        return ISO8601Format()
    }
    
    func toReadable() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: self)
    }
    
    static func create(from: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: from)!
        
        return date
    }
    
    func toDobFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
}
