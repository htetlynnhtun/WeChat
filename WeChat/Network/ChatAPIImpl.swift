//
//  ChatAPIImpl.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation
import FirebaseDatabase

class ChatAPIImpl: ChatAPI {
    
    static let shared = ChatAPIImpl()
    private init() { }
    
    private let ref = Database.database().reference()
    
    func sendP2PMessage(from sender: UserVO, to receiver: UserVO, message: MessageVO) {
        // for sender
        ref
            .child(messagesNode)
            .child(sender.qrCode)
            .child(receiver.qrCode)
            .child(message.id)
            .setValue(message.toAny())
        
        // for receiver
        ref
            .child(messagesNode)
            .child(receiver.qrCode)
            .child(sender.qrCode)
            .child(message.id)
            .setValue(message.toAny())
        
    }
    
    func getMessagesBetween(_ user: UserVO, and other: UserVO, onDataArrived: @escaping ([MessageVO]) -> Void) {
        ref
            .child(messagesNode)
            .child(user.qrCode)
            .child(other.qrCode)
            .observe(.value) { snapshot in
                var messages = [MessageVO]()
                
                snapshot.children.forEach { value in
                    let singleSnapshot = value as! DataSnapshot
                    messages.append(.init(from: singleSnapshot))
                }
                
                onDataArrived(messages)
            }
    }
}
