//
//  RecordView.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/20.
//

import SwiftUI

struct RecordView: View {
    @Binding var sidebarStatus: Int
    
    var body: some View {
        VStack {
            Text("프로젝트 명")
            HStack(spacing: 24) {
                VStack {
                    VStack {
                        Text("평균 연습 소요 시간")
                        Text("00시간 00분")
                    }
                    Divider()
                    VStack {
                        Text("총 연습 횟수")
                        Text("00회")
                    }
                }
                .frame(width: 345)
                VStack {
                    Text("연습 기록 다시보기")
                    List(0...3, id: \.self) { index in
                        HStack {
                            Text("\(index + 1)")
                            Text(Date().description)
                            Text("00:00")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .border(.red)
            ZStack(alignment: .topTrailing) {
                VStack {
                    HStack {
                        Rectangle().frame(width: 14, height: 14)
                        Text("발화 속도가 빠른 구간")
                    }
                    HStack {
                        Rectangle().frame(width: 14, height: 14)
                        Text("발화 속도가 느린 구간")
                    }
                }
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("첫번째 연습의 발화 속도 체크")
                        Text("평균 페이스보다 빠르거나 느리게 말한 부분을 다시 들어보며 체크해보세요.")
                    }
                    HStack {
                        HStack {
                            Image(systemName: "play")
                            Text("00:00")
                        }
                        HStack {
                            ZStack(alignment: .bottomLeading) {
                                HStack {
                                    Rectangle()
                                }
                                .border(.red)
                                .frame(height: 28)
                                VStack(spacing: 0) {
                                    Text("00:00")
                                    TriangleView()
                                        .frame(width: 16, height: 16)
                                        .rotationEffect(.degrees(180))
                                    Rectangle()
                                        .frame(width:2, height: 56)
                                }
                                .frame(width: 40)
                                .offset(x: -20)
                                .border(.red)
                            }
                        }
                        HStack {
                            Text("00:00")
                        }
                    }
                }
                
            }
            .frame(height: 280)
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    @State static var sidebarStatus = 0
    
    static var previews: some View {
        RecordView(sidebarStatus: $sidebarStatus)
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
