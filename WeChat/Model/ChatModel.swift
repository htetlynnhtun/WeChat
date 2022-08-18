//
//  ChatModel.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation

protocol ChatModel {
    func sendP2PMessage(from sender: UserVO, to receiver: UserVO, message: MessageVO)
    func getMessagesBetween(_ user: UserVO, and other: UserVO, onDataArrived: @escaping ([MessageVO]) -> Void)
}

class ChatModelImpl: ChatModel {
    
    static let shared = ChatModelImpl()
    private init() { }
    
    private let api: ChatAPI = ChatAPIImpl.shared
    
    func sendP2PMessage(from sender: UserVO, to receiver: UserVO, message: MessageVO) {
        api.sendP2PMessage(from: sender, to: receiver, message: message)
    }
    
    func getMessagesBetween(_ user: UserVO, and other: UserVO, onDataArrived: @escaping ([MessageVO]) -> Void) {
        api.getMessagesBetween(user, and: other, onDataArrived: onDataArrived)
    }
}
