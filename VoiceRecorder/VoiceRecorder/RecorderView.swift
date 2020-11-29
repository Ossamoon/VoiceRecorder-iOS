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
    private let padding: CGFloat = 1.5
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.02, CGFloat(level) + 40) // between 0.02 and 40
        return CGFloat(level * (260 / 40)) // scaled to max at 260 (our height of our bar)
    }
    
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
                HStack(spacing: 1.5){
                    ForEach(audioRecorder.averagePowerList, id: \.self) {
                        level in
                        PowerBar(numberOfSamples: audioRecorder.numberOfSamples,
                                 value: self.normalizeSoundLevel(level: level),
                                 padding: self.padding
                        )
                    }
                }
                Text(String(format: "current time: %.2f", self.audioRecorder.currentTime))
                Text("終了")
                    .font(.largeTitle)
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
