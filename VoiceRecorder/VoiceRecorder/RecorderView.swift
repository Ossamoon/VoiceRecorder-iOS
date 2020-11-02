//
//  RecorderView.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/11/02.
//

import SwiftUI

struct RecorderView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("録音画面")
            Button("画面を閉じる") {
                self.presentationMode.wrappedValue.dismiss()
            }.padding()
        }
    }
}

struct RecorderView_Previews: PreviewProvider {
    static var previews: some View {
        RecorderView()
    }
}
