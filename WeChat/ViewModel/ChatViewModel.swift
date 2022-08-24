//
//  ChatViewModel.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation
import SwiftUI
import AVFAudio

/// If the chat is for group, isGroupChat must be true.
class ChatViewModel: ObservableObject {
    
    let sender: UserVO
    let receiver: String
    let receiverName: String
    let receiverProfilePicture: URL
    let isGroupChat: Bool
    
    private let model: ChatModel = ChatModelImpl.shared
    private let storageModel: StorageModel = StorageModelImpl.shared
    private var audioRecorder: AVAudioRecorder!
    
    @Published var messages = [MessageVO]()
    @Published var textFieldValue = ""
    @Published var selectedImages = [SelectedImage]()
    @Published var selectedGifs = [SelectedImage]()
    @Published var isShowingPhotoPicker = false
    @Published var isShowingVoiceRecorder = false
    @Published var isShowingGifPicker = false
    
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
        
        if !selectedGifs.isEmpty {
            selectedGifs.forEach { gif in
                if let data = gif.data {
                    storageModel.uploadImage(imageData: data, to: messageImagesDir, fileExtension: "gif") { [weak self] url in
                        guard let self = self else { return }
                        
                        let imageMessage = MessageVO(id: UUID().uuidString,
                                                     type: .gif,
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
            selectedGifs = []
            isShowingGifPicker = false
        }
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to setup recording session")
        }
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFileName = documentPath.appendingPathComponent("temp.m4a")
        
        let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 12000,
                    AVNumberOfChannelsKey: 1,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } catch {
            print("Failed to record")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFileName = documentPath.appendingPathComponent("temp.m4a")
        
        if let data = try? Data(contentsOf: audioFileName) {
            storageModel.uploadAudio(audioData: data) { [weak self] url in
                guard let self = self else { return }
                
                let audioMessage = MessageVO(id: UUID().uuidString,
                                             type: .audio,
                                             payload: url.absoluteString,
                                             userID: self.sender.qrCode,
                                             userName: self.sender.name,
                                             profilePicture: self.sender.profilePicture,
                                             rUserID: self.receiver,
                                             rUserName: self.receiverName,
                                             rProfilePicture: self.receiverProfilePicture,
                                             timestamp: .now)
                self.sendItOut(message: audioMessage)
                
                try? FileManager.default.removeItem(at: audioFileName)
            }
        }
        
    }
    
    func onTapChoosePhoto() {
        isShowingPhotoPicker.toggle()
    }
    
    func onTapChooseGif() {
        isShowingGifPicker.toggle()
    }
    
    func onTapVoiceRecorder() {
        isShowingVoiceRecorder.toggle()
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
