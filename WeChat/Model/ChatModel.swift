//
//  ChatModel.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation

protocol ChatModel {
    func sendP2PMessage(from sender: String, to receiver: String, message: MessageVO)
    func getMessagesBetween(_ user: String, and other: String, onDataArrived: @escaping ([MessageVO]) -> Void)
    func sendGroupMessage(to groupID: String, message: MessageVO)
    func getGroupMessages(for groupID: String, onDataArrived: @escaping ([MessageVO]) -> Void)
}

class ChatModelImpl: ChatModel {
    
    static let shared = ChatModelImpl()
    private init() { }
    
    private let api: ChatAPI = ChatAPIImpl.shared
    
    func sendP2PMessage(from sender: String, to receiver: String, message: MessageVO) {
        api.sendP2PMessage(from: sender, to: receiver, message: message)
    }
    
    func getMessagesBetween(_ user: String, and other: String, onDataArrived: @escaping ([MessageVO]) -> Void) {
        api.getMessagesBetween(user, and: other, onDataArrived: onDataArrived)
    }
    
    func sendGroupMessage(to groupID: String, message: MessageVO) {
        api.sendGroupMessage(to: groupID, message: message)
    }
    
    func getGroupMessages(for groupID: String, onDataArrived: @escaping ([MessageVO]) -> Void) {
        api.getGroupMessages(for: groupID, onDataArrived: onDataArrived)
    }
}
