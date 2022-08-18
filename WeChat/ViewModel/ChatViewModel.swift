//
//  ChatViewModel.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    
    let sender: UserVO
    let receiver: UserVO
    
    private let model: ChatModel = ChatModelImpl.shared
    
    @Published var messages = [MessageVO]()
    @Published var textFieldValue = ""
    
    init(sender: UserVO, receiver: UserVO) {
        self.sender = sender
        self.receiver = receiver
    }
    
    func fetchMessages() {
        model.getMessagesBetween(sender, and: receiver) { [weak self] messages in
            guard let self = self else {return}
            
            let sorted = messages.sorted { a, b in
                a.timestamp.compare(b.timestamp) == .orderedAscending
            }
            
            self.messages = sorted
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
        
        model.sendP2PMessage(from: sender, to: receiver, message: message)
        
        textFieldValue = ""
    }
    
    
    func isInComing(_ message: MessageVO) -> Bool {
        return sender.qrCode != message.userID
    }
    
    func backgroundColor(for message: MessageVO) -> Color {
        return isInComing(message) ? Color.colorGray2.opacity(0.5): .colorPrimary
    }
}
