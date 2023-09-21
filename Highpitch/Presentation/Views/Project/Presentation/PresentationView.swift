//
//  PresentationView.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/20.
//

import SwiftUI

struct PresentationView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var sidebarStatus: Int
    
    var body: some View {
        VStack(spacing: 0) {
            // header
            HStack {
                Button("<") {
//                    print("<")
                    sidebarStatus = 0
                    dismiss()
                }
                .frame(width: 120, alignment: .leading)
                Spacer()
                Text("프로젝트 명")
                Spacer()
                Button("연습 끝내기") {
//                    print("<")
                    sidebarStatus = 1
//                    dismiss()
                }
                .frame(width: 120, alignment: .trailing)
            }
            .border(.gray)
            .frame(maxWidth: .infinity)
            // body
            VStack {
                // PDFView
                ZStack {
                    Image(.SystemImage.mainLogo.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // footer
            HStack {
                HStack {
                    Image(systemName: "mic.circle.fill")
                    Text("REC")
                    Circle().frame(width: 20, height: 20)
                }
                Spacer()
                HStack {
                    Button(">") {
                        print("녹음 시작..!")
                    }
                    Text("00:00")
                }
                Spacer()
                HStack {
                    Text("00:00")
                    Text("7/10(페이지)")
                }
            }
            .frame(height: 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct PresentationView_Previews: PreviewProvider {
    @State static var sidebarStatus = 0
    
    static var previews: some View {
        PresentationView(sidebarStatus: $sidebarStatus)
    }
}
