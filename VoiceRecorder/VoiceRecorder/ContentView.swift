//
//  ContentView.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/11/02.
//

import SwiftUI

struct ContentView: View {
    @State var showRecorderView: Bool = false
    var body: some View {
        VStack {
            NavigationView {
                List {
                    NavigationLink(destination: PlayerView(number: "1") ) {
                        Text("個々の録音データ1")
                    }
                    NavigationLink(destination: PlayerView(number: "2") ) {
                        Text("個々の録音データ2")
                    }
                }
                .navigationTitle("録音データリスト")
            }
            
            Button(action: {
                self.showRecorderView = true
            }) {
                Text("録音！！")
            }
            .sheet(isPresented: self.$showRecorderView) {
                RecorderView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
