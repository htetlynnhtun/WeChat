//
//  AudioManager.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import Foundation
import AVFoundation

protocol AudioManager {
    func load(audio url: String)
    func play()
    func pause()
}

class AudioManagerImpl: AudioManager {
    private var audioPlayer = AVPlayer()
    static let shared = AudioManagerImpl()
    private init() { }
    
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
}
