//
//  RecordingRow.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/11/03.
//

import SwiftUI

struct RecordingRow: View {
    
    var audioURL: URL
        
    var body: some View {
        HStack {
            Text("\(audioURL.lastPathComponent)")
            Spacer()
        }
    }
}

/*
struct RecordingRow_Previews: PreviewProvider {
    static var previews: some View {
        RecordingRow()
    }
}
*/
