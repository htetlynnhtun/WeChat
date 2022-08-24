//
//  ChatHistoryViewModel.swift
//  WeChat
//
//  Created by kira on 20/08/2022.
//

import Foundation
import Combine

class ChatHistoryViewModel: ObservableObject {
    
    private let qrCode: String
    private let chatModel: ChatModel = ChatModelImpl.shared
    
    @Published var messages = [MessageVO]()
    @Published private var latestMessages = [MessageVO]()
    @Published private var latestGroupMessages = [MessageVO]()
    private var cancellables = [AnyCancellable]()
    
    init(qrCode: String) {
        self.qrCode = qrCode
        
        $latestMessages.combineLatest($latestGroupMessages)
            .sink { [weak self] latestMsg, latestGroupMsg in
                guard let self = self else { return }
                
                var combinedMessages = latestMsg
                combinedMessages.append(contentsOf: latestGroupMsg)
                let sorted = combinedMessages.sorted { a, b in
                    a.timestamp.compare(b.timestamp) == .orderedDescending
                }
                
                self.messages = sorted
            }
            .store(in: &cancellables)
    }
    
    func fetchLatestMessages() {
        chatModel.getLatestMessages(for: qrCode) { [weak self] messages in
            guard let self = self else { return }
            
            self.latestMessages = messages
        }
        
        chatModel.getLatestGroupMessages(for: qrCode) { [weak self] messages in
            guard let self = self else { return }

            self.latestGroupMessages = messages
        }
    }
    
    func previewMessage(for message: MessageVO) -> String {
        let sender = message.userID == qrCode ? "You" : message.userName
        
        return "\(sender): \(message.payload)"
    }
    
    func dateTime(for message: MessageVO) -> String {
        message.timestamp.formatForChatMessage()
    }
    
    func profileLink(for message: MessageVO) -> URL {
        if let groupPicture = message.groupPicture {
            return groupPicture
        } else {
            return message.userID == qrCode ? message.rProfilePicture : message.profilePicture
        }
    }
    
    func username(for message: MessageVO) -> String {
        if let groupName = message.groupName {
            return groupName
        } else {
            return message.userID == qrCode ? message.rUserName : message.userName
        }
    }
    
    func receiver(for message: MessageVO) -> String {
        if let groupID = message.groupID {
            return groupID
        } else {
            return message.userID == qrCode ? message.rUserID : message.userID
        }
    }
    
}
