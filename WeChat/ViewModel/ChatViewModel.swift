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
    private let storageModel: StorageModel = StorageModelImpl.shared
    
    @Published var messages = [MessageVO]()
    @Published var textFieldValue = ""
    @Published var selectedImages = [SelectedImage]()
    @Published var isShowingPhotoPicker = false
    
    init(sender: UserVO, receiver: String, receiverName: String, receiverProfilePicture: URL, isGroupChat: Bool = false) {
        self.sender = sender
        self.receiver = receiver
        self.receiverName = receiverName
        self.receiverProfilePicture = receiverProfilePicture
        self.isGroupChat = isGroupChat
    }
    
    func fetchMessages() {
        if (isGroupChat) {
            model.getGroupMessages(for: receiver) { [weak self] messages in
                guard let self = self else { return }
                
                let sorted = messages.sorted { a, b in
                    a.timestamp.compare(b.timestamp) == .orderedAscending
                }
                
                self.messages = sorted
            }
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
        // For text message
        if textFieldValue.isNotEmpty {
            let textMessage = MessageVO(id: UUID().uuidString,
                                        type: .text,
                                        payload: textFieldValue,
                                        userID: sender.qrCode,
                                        userName: sender.name,
                                        profilePicture: sender.profilePicture,
                                        rUserID: receiver,
                                        rUserName: receiverName,
                                        rProfilePicture: receiverProfilePicture,
                                        timestamp: Date.now)
            sendItOut(message: textMessage)
            textFieldValue = ""
        }
        
        // For image message
        if !selectedImages.isEmpty {
            selectedImages.forEach { image in
                if let pngData = image.image.pngData() {
                    storageModel.uploadImage(imageData: pngData, to: messageImagesDir) { [weak self] url in
                        guard let self = self else { return }
                        
                        let imageMessage = MessageVO(id: UUID().uuidString,
                                                     type: .image,
                                                     payload: url.absoluteString,
                                                     userID: self.sender.qrCode,
                                                     userName: self.sender.name,
                                                     profilePicture: self.sender.profilePicture,
                                                     rUserID: self.receiver,
                                                     rUserName: self.receiverName,
                                                     rProfilePicture: self.receiverProfilePicture,
                                                     timestamp: Date.now)
                        self.sendItOut(message: imageMessage)
                    }
                }
            }
            selectedImages = []
            isShowingPhotoPicker = false
        }
    }
    
    func onTapChoosePhoto() {
        isShowingPhotoPicker.toggle()
    }
    
    
    func isInComing(_ message: MessageVO) -> Bool {
        return sender.qrCode != message.userID
    }
    
    func backgroundColor(for message: MessageVO) -> Color {
        return isInComing(message) ? Color.colorGray2.opacity(0.5): .colorPrimary
    }
    
    private func sendItOut(message: MessageVO) {
        if (isGroupChat) {
            model.sendGroupMessage(to: receiver, message: message)
        } else {
            model.sendP2PMessage(from: sender.qrCode, to: receiver, message: message)
        }
    }
}
