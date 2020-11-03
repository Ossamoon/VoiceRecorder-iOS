//
//  VoiceRecorderApp.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/11/02.
//

import SwiftUI

@main
struct VoiceRecorderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(audioRecorder: AudioRecorder())
        }
    }
}
