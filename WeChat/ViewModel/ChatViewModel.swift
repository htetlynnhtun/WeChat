//
//  ChatViewModel.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation
import SwiftUI

/// If the chat is for group, isGroupChat must be true.
class ChatViewModel: ObservableObject {
    
    let sender: UserVO
    let receiver: String
    let receiverName: String
    let receiverProfilePicture: URL
    let isGroupChat: Bool
    
    private let model: ChatModel = ChatModelImpl.shared
    
    @Published var messages = [MessageVO]()
    @Published var textFieldValue = ""
    
    init(sender: UserVO, receiver: String, receiverName: String, receiverProfilePicture: URL, isGroupChat: Bool = false) {
        self.sender = sender
        self.receiver = receiver
        self.receiverName = receiverName
        self.receiverProfilePicture = receiverProfilePicture
        self.isGroupChat = isGroupChat
    }
    
    func fetchMessages() {
        if (isGroupChat) {
            // fetchGroupMessages
        } else {
            model.getMessagesBetween(sender.qrCode, and: receiver) { [weak self] messages in
                guard let self = self else {return}
                
                let sorted = messages.sorted { a, b in
                    a.timestamp.compare(b.timestamp) == .orderedAscending
                }
                
                self.messages = sorted
            }
        }
    }
    
    func sendMessage() {
        guard textFieldValue.isNotEmpty else { return }
        
        let message = MessageVO(id: UUID().uuidString,
                                type: .text,
                                payload: textFieldValue,
                                userID: sender.qrCode,
                                userName: sender.name,
                                profilePicture: sender.profilePicture,
                                timestamp: Date.now)
        
        if (isGroupChat) {
            // sendGroupMessage
        } else {
            model.sendP2PMessage(from: sender.qrCode, to: receiver, message: message)
        }
        
        textFieldValue = ""
    }
    
    
    func isInComing(_ message: MessageVO) -> Bool {
        return sender.qrCode != message.userID
    }
    
    func backgroundColor(for message: MessageVO) -> Color {
        return isInComing(message) ? Color.colorGray2.opacity(0.5): .colorPrimary
    }
}
