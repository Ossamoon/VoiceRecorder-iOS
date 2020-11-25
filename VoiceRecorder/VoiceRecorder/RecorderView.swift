//
//  RecorderView.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/11/02.
//

import SwiftUI

struct RecorderView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var audioRecorder = AudioRecorder()
    
    var body: some View {
        VStack {
            if audioRecorder.recording == false {
                Text("録音")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                Button(action: {
                    self.audioRecorder.startRecording()
                }) {
                    Image(systemName: "record.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.red)
                        .padding()
                }
            } else {
                Text("終了")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                Text(String(self.audioRecorder.currentTime))
                Text(String(self.audioRecorder.averagePower))
                Button(action: {
                    self.audioRecorder.stopRecording()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "stop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding()
                }
            }
        }
    }
}

struct RecorderView_Previews: PreviewProvider {
    static var previews: some View {
        RecorderView(audioRecorder: AudioRecorder())
    }
}
