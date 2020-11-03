//
//  PlayerView.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/11/02.
//

import SwiftUI

struct PlayerView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    var number: String
    
    var body: some View {
        VStack {
            Text("再生画面" + number)
                .font(.title)
            Text("切替で表示する画面")
                .padding()
        }
        .navigationBarTitle("再生画面", displayMode: .inline)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(audioRecorder: AudioRecorder(), number: "_test")
    }
}

