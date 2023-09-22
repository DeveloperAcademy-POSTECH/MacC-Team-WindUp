//
//  RecordView.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/20.
//

import SwiftUI

struct RecordView: View {
    @Environment(\.dismiss) private var dismiss
    @State var isPresentationModeOpen = false
    @State var selected: Int = 0
    @EnvironmentObject var projectVM: ProjectVM
    @Binding var navigationPath: [Route]
    
    var body: some View {
        VStack(spacing: 0) {
            toolbarView()
            HStack(spacing: 0) {
                sidebarView()
                recordContentContainerView()
                    .frame(maxWidth: .infinity)
            }
            .border(.red)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
//        .navigationDestination(isPresented: $isPresentationModeOpen) {
//            PresentationView()
////                .toolbar(.hidden)
//                .environmentObject(projectVM)
//        }
    }
}

//struct RecordView_Previews: PreviewProvider {
//    @State static var sidebarStatus = 0
//
//    static var previews: some View {
//        RecordView()
//    }
//}

extension RecordView {
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
                    dismiss()
                }
                HPButton(
                    label: "toggle left sidebar",
                    icon: SFSymbols.sidebarLeft.rawValue,
                    alignStyle: .iconOnly, size: .xlarge,
                    type: .text,
                    color: .systemGray600,
                    width: 48
                ) {
                    print("sidebar 조절")
                }
            }
            .frame(width: 200, alignment: .topLeading)
            Spacer()
            Text("연습 기록보기")
                .systemFont(.subTitle)
            Spacer()
            HStack {}.frame(width: 200)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, minHeight: 86, maxHeight: 86)
        .border(width: 1, edges: [.bottom], color: .systemGray400)
        .background(Color.systemWhite)
    }
    
    private func sidebarView() -> some View {
        VStack {
            Label("연습 기록보기", systemImage: SFSymbols.newPaper.rawValue)
                .labelStyle(SidebarLabelStyle(iconColor: .HPPrimary.primary))
        }
        .padding(26)
        .frame(minWidth: 172, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.systemWhite)
    }
    
    private func recordContentContainerView() -> some View {
        VStack(spacing: 0) {
            recordContainerHeaderView()
            recordContainerBodyView()
            recordContainerFooterView()
        }
        .padding(.vertical, 48)
        .padding(.horizontal, 76)
    }
    
    private func recordContainerHeaderView() -> some View {
        HStack {
            Text("프로젝트 명")
                .systemFont(.headline)
            Spacer()
            HPButton(label: "연습 하러가기", size: .xlarge, width: 160) {
//                isPresentationModeOpen = true
                navigationPath.append(.view2)
            }
        }
    }
    
    private func recordContainerBodyView() -> some View {
        HStack(spacing: 24) {
            // left
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("평균 연습 소요 시간")
                        .systemFont(.subTitle)
                    Text("00시간 00분")
                        .systemFont(.headline)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("총 연습 횟수")
                        .systemFont(.subTitle)
                    Text("00회")
                        .systemFont(.headline)
                    Spacer()
                }
                .padding(.top, 40)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .border(width: 1, edges: [.top], color: .systemGray500)
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 24)
            .frame(maxWidth: 345, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.systemWhite)
            .cornerRadius(12)
            // right
            VStack(alignment: .leading) {
                Text("연습 기록 다시보기")
                    .systemFont(.subTitle)
                List(0...3, id: \.self) { index in
                    HStack {
                        Text("\(index + 1)")
                            .frame(width: 40)
                        Text(Date().description)
                            .frame(maxWidth: .infinity)
                        Text("00:00")
                            .frame(width: 48)
                    }
                    .frame(maxWidth: .infinity, minHeight: 36)
                    .background(selected == index ? Color.HPPrimary.lightness : Color.clear)
                    .cornerRadius(4)
                    .onTapGesture {
                        selected = index
                    }
                }
                .listRowInsets(.none)
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.systemWhite)
            .cornerRadius(12)
        }
        .padding(.top, 40)
    }
    
    private func recordContainerFooterView() -> some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                HStack {
                    Rectangle().frame(width: 14, height: 14)
                        .foregroundColor(.HPSecondary.purple)
                    Text("발화 속도가 빠른 구간")
                        .systemFont(.caption2)
                }
                HStack {
                    Rectangle().frame(width: 14, height: 14)
                        .foregroundColor(.HPSecondary.yellow)
                    Text("발화 속도가 느린 구간")
                        .systemFont(.caption2)
                }
            }
            VStack(alignment: .leading, spacing: 48) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("첫번째 연습의 발화 속도 체크")
                        .systemFont(.headline)
                    Text("평균 페이스보다 빠르거나 느리게 말한 부분을 다시 들어보며 체크해보세요.")
                        .systemFont(.caption1)
                        .foregroundColor(.systemGray600)
                }
                HStack(alignment: .bottom, spacing: 16) {
                    HStack(spacing: 8) {
                        Image(systemName: SFSymbols.play.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("00:00")
                            .systemFont(.caption1)
                            .foregroundColor(.systemGray600)
                    }
                    .padding(.bottom, 8)
                    HStack {
                        ZStack(alignment: .bottomLeading) {
                            HStack {
                                Rectangle()
                                    .foregroundColor(.systemGray500)
                            }
                            .cornerRadius(4)
                            .frame(height: 28)
                            VStack(spacing: 0) {
                                Text("00:00")
                                    .systemFont(.caption2)
                                    .foregroundColor(.HPPrimary.primary)
                                Image(systemName: SFSymbols.play.rawValue)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .rotationEffect(.degrees(90))
                                    .offset(y: 2)
                                Rectangle()
                                    .frame(width:2, height: 54 - 8)
                            }
                            .frame(width: 40)
                            .offset(x: -20)
                        }
                    }
                    HStack {
                        Text("00:00")
                            .systemFont(.caption1)
                            .foregroundColor(.systemGray600)
                    }
                    .padding(.bottom, 8)
                }
            }
            
        }
        .padding(.vertical, 40)
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity, maxHeight: 280, alignment: .topLeading)
        .background(Color.systemWhite)
        .cornerRadius(12)
        .padding(.top, 32)
        .padding(.bottom, 56)
    }
    
}

struct SidebarLabelStyle: LabelStyle {
    var iconColor: Color = .systemGray600
    var textColor: Color = .systemBlack
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            configuration.icon
                .foregroundColor(iconColor)
            configuration.title
                .foregroundColor(textColor)
        }
        .systemFont(.body)
    }
}

struct TriangleView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                // 삼각형의 꼭지점 좌표
                let point1 = CGPoint(x: width / 2, y: 0)
                let point2 = CGPoint(x: 0, y: height)
                let point3 = CGPoint(x: width, y: height)
                
                // Path에 세 꼭지점을 연결하여 삼각형 그리기
                path.move(to: point1)
                path.addLine(to: point2)
                path.addLine(to: point3)
                path.closeSubpath()
            }
            .fill(Color.blue) // 삼각형을 채우기 위한 색상 지정
            .cornerRadius(2)
        }
    }
}
