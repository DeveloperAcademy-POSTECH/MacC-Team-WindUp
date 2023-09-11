//
//  TestView.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            #if os(macOS)
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, macOS")
            #else
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, iOS")
            #endif
            Text("Branch Test")
        }
        .padding()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("Mac")
                .previewDisplayName("Mac Preview")
            ContentView()
                .previewDevice("iPhone 14")
                .previewDisplayName("iPhone 14 Preview")
        }
    }
}
