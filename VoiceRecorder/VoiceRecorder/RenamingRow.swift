//
//  RenamingRow.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/12/13.
//

import SwiftUI

struct RenamingRow: View {
    
    @ObservedObject var audioRecorder : AudioRecorder
    var audioURL: URL
    @State var filename: String = ""
    @State private var isEditing = false
    
    var body: some View {
        TextField(
                "filename",
                 text: $filename
            ) { isEditing in
                self.isEditing = isEditing
            } onCommit: {
                audioRecorder.updateRecordingName(from: audioURL, to: URL(string: filename, relativeTo: audioURL)!)
            }
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .border(Color(UIColor.separator))
    }
}
/*
struct RenamingRow_Previews: PreviewProvider {
    static var previews: some View {
        RenamingRow()
    }
}
*/
