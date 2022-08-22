//
//  VoiceRecorderView.swift
//  WeChat
//
//  Created by kira on 22/08/2022.
//

import SwiftUI

struct VoiceRecorderView: View {
    @State private var isRecording = false
    
    @EnvironmentObject var chatVM: ChatViewModel
    
    var body: some View {
        VStack {
            Text(isRecording ? "Recording started" : "Recording stopped")
            
            Button {
                isRecording.toggle()
                
                if isRecording {
                    chatVM.startRecording()
                } else {
                    chatVM.stopRecording()
                }
            } label: {
                Image(systemName: isRecording ? "record.circle.fill" : "record.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.colorPrimary)
            }

        }
    }
}

struct VoiceRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecorderView()
    }
}
