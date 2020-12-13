//
//  ContentView.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/11/02.
//

import SwiftUI

struct ContentView: View {
    
    @State var showRecorderView: Bool = false
    @State var editingFile: String? = nil
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(audioRecorder.recordings, id: \.createdAt) {
                        recording in
                        NavigationLink(destination: PlayerView(audioURL: recording.fileURL)) {
                            if recording.fileURL.lastPathComponent == self.editingFile {
                                let temp = recording.fileURL.lastPathComponent
                                let temp2 = substr(temp, 0, temp.count - 5)
                                RenamingRow(audioRecorder: self.audioRecorder, audioURL: recording.fileURL, filename: temp2)
                            }
                            else {
                                RecordingRow(audioURL: recording.fileURL)
                            }
                        }
                        .contextMenu(ContextMenu(menuItems: {
                            Text(recording.fileURL.lastPathComponent)
                            Button(action: {
                                self.editingFile = recording.fileURL.lastPathComponent
                            }) {
                                Text("Rename")
                            }
                            Button(action: {
                                audioRecorder.deleteRecording(urlsToDelete: [recording.fileURL])
                            }) {
                                Text("Delete")
                            }
                        }))
                    }
                    .onDelete(perform: delete)
                }
                .navigationTitle("録音データリスト")
                //.navigationBarItems(trailing: EditButton())
            }
            
            Button(action: {
                self.showRecorderView = true
            }) {
                Text("　録音　")
                    .font(.title)
                    .padding()
                    .foregroundColor(Color.gray)
                    .background(Color(.green))
                    .cornerRadius(10)
            }
            .sheet(isPresented: self.$showRecorderView) {
                RecorderView(audioRecorder: self.audioRecorder)
            }
        }
    }
    
    let substr : (String, Int, Int) -> String = { text, from, length in
        let to = text.index(text.startIndex, offsetBy:from + length)
        let from = text.index(text.startIndex, offsetBy:from)
        return String(text[from...to])
    }
    
    private func delete(at offsets: IndexSet) {
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
