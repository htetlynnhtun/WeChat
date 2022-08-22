//
//  VoiceMessageViewModel.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import Foundation

class VoiceMessageViewModel: ObservableObject {
    let message: MessageVO
    private var audioManager: AudioManager = AudioManagerImpl.shared
    
    @Published var isPlaying = false
    @Published var audioFileURL: URL?
    
    init(message: MessageVO) {
        self.message = message
        audioManager.delegates.append(self)
        
        let cachesFolderURL = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = cachesFolderURL!.appendingPathComponent("\(message.id).mp3")
        let isAlreadyDownloaded = FileManager.default.fileExists(atPath: fileURL.path)
        
        if (isAlreadyDownloaded) {
            audioFileURL = fileURL
        } else {
            let task = URLSession.shared.downloadTask(with: URL(string: message.payload)!) { tempUrl, urlResponse, error in
                guard let tempUrl = tempUrl else { return }

                do {
                    try FileManager.default.copyItem(at: tempUrl, to: fileURL)
                    
                    DispatchQueue.main.async {
                        self.audioFileURL = fileURL
                    }
                } catch {
                    print("Failed to save audio file: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
    
    func onTap() {
        isPlaying.toggle()
        
        if (isPlaying) {
            audioManager.load(audio: self.message.payload)
            audioManager.play()
        } else {
            audioManager.pause()
        }
    }
    
    func stopPlayer() {
        if (isPlaying) {
            audioManager.pause()
        }
    }
    
    deinit {
        print("\(self) is about to deinit")
    }
}

extension VoiceMessageViewModel: AudioManagerDelegate {
    func didFinishPlaying() {
        isPlaying = false
    }
}
