//
//  ContentView.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/11.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
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
