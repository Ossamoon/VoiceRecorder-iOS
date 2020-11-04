//
//  PlayerView.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/11/02.
//

import SwiftUI

struct PlayerView: View {
    
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var audioURL: URL
    
    var body: some View {
        VStack {
            if audioPlayer.isPlaying == false {
                Button(action: {
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                }) {
                    Image(systemName: "play.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .padding()
                }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .padding()
                }
            }
            Text("\(audioURL.lastPathComponent)" + "を再生")
                .font(.title)
                .padding()
        }
        .navigationBarTitle(Text("\(audioURL.lastPathComponent)"), displayMode: .inline)
    }
}

/*
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
*/
