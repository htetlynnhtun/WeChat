//
//  AudioManager.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import Foundation
import AVFoundation

protocol AudioManager {
    var delegates: [AudioManagerDelegate] { get set }
    func load(audio url: String)
    func play()
    func pause()
}

protocol AudioManagerDelegate {
    func didFinishPlaying()
}

class AudioManagerImpl: AudioManager {
    
    private var audioPlayer = AVPlayer()
    static let shared = AudioManagerImpl()
    var delegates = [AudioManagerDelegate]()
    
    private init() {
        NotificationCenter.default
            .addObserver(self,
            selector: #selector(playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: audioPlayer.currentItem
        )
    }
    
    func load(audio url: String) {
        audioPlayer = AVPlayer(url: URL(string: url)!)
    }
    
    func play() {
        audioPlayer.play()
    }
    
    func pause() {
        print("Pausing audio player")
        audioPlayer.pause()
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        delegates.forEach { delegate in
            delegate.didFinishPlaying()
        }
    }
}
