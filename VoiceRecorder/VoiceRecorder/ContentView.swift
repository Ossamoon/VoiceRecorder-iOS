//
//  ContentView.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/11/02.
//

import SwiftUI

struct ContentView: View {
    
    @State var showRecorderView: Bool = false
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(audioRecorder.recordings, id: \.createdAt) {
                        recording in
                        NavigationLink(destination: PlayerView(audioURL: recording.fileURL)) {
                            RecordingRow(audioURL: recording.fileURL)
                        }
                    }
                    .onDelete(perform: delete)
                }
                .navigationTitle("録音データリスト")
                .navigationBarItems(trailing: EditButton())
            }
            
            Button(action: {
                self.showRecorderView = true
            }) {
                Text("録音！！")
            }
            .sheet(isPresented: self.$showRecorderView) {
                RecorderView(audioRecorder: self.audioRecorder)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
            
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(audioRecorder: AudioRecorder())
    }
}
