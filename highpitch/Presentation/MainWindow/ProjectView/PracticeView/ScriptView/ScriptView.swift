//
//  ScriptView.swift
//  highpitch
//
//  Created by yuncoffee on 10/14/23.
//

import SwiftUI

struct ScriptView: View {
    @Binding
    var practice: PracticeModel
    
    var body: some View {
        VStack(spacing: 0) {
            List(practice.utterances, id: \.id) { utterance in
                HStack {
                    Text("\(utterance.message)")
                    Spacer()
                    VStack {
                        Text("startAt: \(utterance.startAt)")
                        Text("duration: \(utterance.duration)")
                    }
                }
            }
            .padding(.bottom, 64)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .border(.blue)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
}

// message, startAt, 
struct SentenceData: Identifiable {
    var id = UUID()
    
}

extension ScriptView {
    
    
}
