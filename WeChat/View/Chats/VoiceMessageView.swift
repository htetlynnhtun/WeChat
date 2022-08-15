//
//  VoiceMessageView.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import SwiftUI

struct VoiceMessageView: View {
    var currentUser = "John"
    @ObservedObject var vm: VoiceMessageViewModel
//    @StateObject private var vm: VoiceMessageViewModel
    
//    init(message: MessageVO) {
//        self.message = message
//        _vm = StateObject(wrappedValue: VoiceMessageViewModel(message: message))
//    }
    
    
    
    private var isIncoming: Bool {
        return currentUser != vm.message.sender
    }
    
    private var waveformBarColor: UIColor {
        return isIncoming ? UIColor(.colorPrimary) : UIColor(.colorWCGreen)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    vm.onTap()
                } label: {
                    Image(systemName: vm.isPlaying ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(isIncoming ? .white : .colorPrimary)
                        .padding(8)
                        .background(isIncoming ? Color.colorPrimary : .white)
                        .clipShape(Circle())
                }
                
                if (vm.audioFileURL != nil) {
                    WaveformImageViewUI(audioURL: vm.audioFileURL!,
                                        configuration: .init(size: .init(width: 100, height: 30),
                                                             backgroundColor: .clear,
                                                             style: .striped(.init(color: waveformBarColor,width: 2, spacing: 4, lineCap: .round)),
                                                             dampening: .init(percentage: 0.25, sides: .both, easing: {$0}),
                                                             position: .middle,
                                                             scale: 1,
                                                             verticalScalingFactor: 0.65,
                                                             shouldAntialias: false))
                        .frame(width: 100, height: 30)
                } else {
                    Rectangle()
                        .frame(width: 100, height: 30)
                        .foregroundColor(.green)
                }
                
            }
            
            HStack {
                Text("00:19")
                    .font(.system(size: 12))
                
                Spacer()
                    .frame(maxWidth: 70)
                
                Text(vm.message.date)
                    .font(.system(size: 8))
            }
            .foregroundColor(isIncoming ? .colorGray : .white)
        }
        .onDisappear {
            vm.stopPlayer()
        }
    }
}

struct VoiceMessageView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageView(vm: VoiceMessageViewModel(message: MockDataViewModel().messages[0]))
            .previewLayout(.sizeThatFits)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
