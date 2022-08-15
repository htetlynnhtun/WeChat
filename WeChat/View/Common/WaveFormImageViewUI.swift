//
//  WaveFormImageView.swift
//  WeChat
//
//  Created by kira on 30/07/2022.
//

import DSWaveformImage
import Foundation
import SwiftUI

public struct WaveformImageViewUI: UIViewRepresentable {
    let audioURL: URL
    var configuration: Waveform.Configuration
    
    public init(audioURL: URL, configuration: Waveform.Configuration) {
        self.audioURL = audioURL
        print(self.audioURL)
        self.configuration = configuration
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public func makeUIView(context: Context) -> UIView {
        let waveformView = WaveformImageView(frame: .init(x: 0, y: 0, width: 100, height: 30))
        waveformView.configuration = configuration
        waveformView.waveformAudioURL = audioURL
        context.coordinator.waveformView = waveformView
        return waveformView
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        let waveformView = context.coordinator.waveformView!
        waveformView.configuration = configuration
        waveformView.waveformAudioURL = audioURL
    }
    
    public class Coordinator: NSObject {
        var waveformView: WaveformImageView!
        
        override init() {}
    }
}
