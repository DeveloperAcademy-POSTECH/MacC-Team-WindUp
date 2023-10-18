//
//  AudioControllerView.swift
//  highpitch
//
//  Created by yuncoffee on 10/14/23.
//

import SwiftUI

struct AudioControllerView: View {
    @State
    private var speed = 50.0
    @State
    private var isEditing = false
    
    @Binding
    var practice: PracticeModel
    
    var body: some View {
        VStack {
            Slider(
                value: $speed,
                in: 0...100,
                onEditingChanged: { editing in
                    isEditing = editing
                }
            )
            Text("\(speed)")
                .foregroundColor(isEditing ? .red : .blue)
            HStack {
                if let urlString = practice.audioPath?.absoluteString {
                    Text("URL: \(urlString)")
                } else {
                    Text("유효하지 않은 URL")
                }
                // Text(practice.audioPath!.absoluteString)
                Button {
                 print("prev")
                } label: {
                    Text("prev")
                }
                Button {
                 print("play")
                } label: {
                    Text("play")
                }
                Button {
                 print("next")
                } label: {
                    Text("next")
                }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 64)
        .border(.red, width: 2)
    }
}

// #Preview {
//    @State var practice = Practice(audioPath: Bundle.main.bundleURL, utterances: [])
//    return AudioControllerView(practice: $practice)
// }
