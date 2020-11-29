//
//  PowerBar.swift
//  VoiceRecorder
//
//  Created by 齋藤修 on 2020/11/29.
//

import SwiftUI

struct PowerBar: View {
    private let numberOfSamples: Int
    private var value: CGFloat
    private let padding: CGFloat
    
    init(numberOfSamples: Int, value: CGFloat, padding: CGFloat){
        self.numberOfSamples = numberOfSamples
        self.value =  value
        self.padding = padding
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: (UIScreen.main.bounds.width / CGFloat(numberOfSamples) - padding),
                       height: value)
                .foregroundColor(.green)
        }
    }
}

/*
struct PowerBar_Previews: PreviewProvider {
    static var previews: some View {
        PowerBar()
    }
}
*/
