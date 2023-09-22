//
//  PresentationView.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/20.
//

import SwiftUI

struct PresentationView: View {
    @EnvironmentObject var projectVM: ProjectVM
    @Environment(\.dismiss) private var dismiss
    @Binding var navigationPath: [Route]
    
    var body: some View {
        VStack(spacing: 0) {
            // header
            toolbarView()
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
            bottomToolbar()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

//struct PresentationView_Previews: PreviewProvider {
//    @State static var sidebarStatus = 0
//
//    static var previews: some View {
//        PresentationView()
//    }
//}

extension PresentationView {
    private func toolbarView() -> some View {
        HStack {
            HStack(spacing: 24) {
                HPButton(
                    label: "Home",
                    icon: SFSymbols.home.rawValue,
                    alignStyle: .iconOnly, size: .xlarge,
                    type: .text,
                    color: .systemGray600,
                    width: 48
                ) {
                    navigationPath.removeAll()
                }
                HPButton(
                    label: "Redo",
                    icon: SFSymbols.chevronLeft.rawValue,
                    alignStyle: .iconOnly, size: .xlarge,
                    type: .text,
                    color: .systemGray600,
                    width: 48
                ) {
                    navigationPath.removeLast()
                }
            }
            .frame(width: 200, alignment: .topLeading)
            Spacer()
            Text("프로젝트 명")
                .systemFont(.subTitle)
            Spacer()
            HStack {
                HPButton(label: "연습 끝내기", size: .xlarge, width: 160) {
                    navigationPath.removeLast()
                }
            }.frame(width: 200, alignment: .trailing)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, minHeight: 86, maxHeight: 86)
        .border(width: 1, edges: [.bottom], color: .systemGray400)
        .background(Color.systemWhite)
    }
    
    private func bottomToolbar() -> some View {
        HStack(spacing: 0) {
            HStack {
                Image(systemName: "mic.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("REC")
                    .systemFont(.subTitle)
                Circle().frame(width: 20, height: 20)
            }
            Spacer()
            HStack {
                Button {
                    print("녹음 시작..!")
                } label: {
                    Label("Play", systemImage: SFSymbols.play.rawValue)
                        .font(.system(size: 28))
                        .foregroundColor(.systemBlack)
                        .labelStyle(.iconOnly)
                }
                .frame(width: 48, height: 48)
                .buttonStyle(.plain)
                Text("00:00")
                    .systemFont(.headline)
            }
            Spacer()
            HStack {
                Text("7/10(페이지)")
                    .systemFont(.subTitle)
                    .foregroundColor(.systemGray600)
            }
        }
        .padding(.horizontal, 48)
        .frame(height: 100)
    }
}
