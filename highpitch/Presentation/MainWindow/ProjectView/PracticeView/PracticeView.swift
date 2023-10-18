//
//  PracticeView.swift
//  highpitch
//
//  Created by yuncoffee on 10/13/23.
//

import SwiftUI

/**
 연습 회차별 피드백
 연습 회차별 피드백 UI 그리기
 연습리스트 불러오기
 연습 날짜 출력
 소요시간 출력
 레벨/점수 출력
 자세히 보기 버튼 구현
 편집 기능 구현
 삭제 기능
 
 특정 회차 연습 UI 그리기
 특정 연습 날짜+요일+시간(초까지) 출력
 지난 포즈필러 대비 이번 포즈필러 비율 계산 및 출력
 지난 포즈필러비율 출력
 상위 10% 필러워드비율 출력
 3회 이상 반복된 필러워드 분류 후 출력
 필러워드 상세보기에서의 데이터 출력
 말 빠르게 말하기 비율 출력
 빠르기에 대한 평가 택스트 출력
 이전 말 빠르기 데이터 그래프로 출력
 이번 말 빠르기 데이터 그래프로 출력
 그래프 클릭 시 재생 구간 이동 (재생시 그 구간부터 계속 재생)
 
 내 발표 다시보기
 발표 대본 STT로 된거 출력
 재생되고 있는 구간 표시
 필러워드 표시
 말 빠르기 구간 표시
 
 음성 불러오기 기능
 재생바 기능 구현 (드래그 및 재생 시 이동)
 재생 버튼 구현
 일시정지 버튼 구형
 10초 앞으로 구현
 10초 뒤로 구현
 */

struct PracticeView: View {
    @Environment(ProjectManager.self)
    private var projectManager
    
    @State 
    var practice: PracticeModel

    var body: some View {
        VStack(spacing: 0) {
            /// 연습 메타데이터(연습 횟수, 연습일)
            practiceHeader
            ZStack(alignment: .bottom) {
                practiceContentsContainer
                /// 오디오 컨트롤 뷰
                AudioControllerView(practice: $practice)
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .border(.red, width: 2)
        //        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        .onAppear {
            print(projectManager.current)
        }
        .onChange(of: projectManager.current) { oldValue, newValue in
            print(newValue)
        }
    }
}

extension PracticeView {
    @ViewBuilder
    private var practiceHeader: some View {
        HStack {
            Text("n번째 연습")
            Text("연습 시간")
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .border(.red, width: 2)
    }
    
    @ViewBuilder
    private var practiceContentsContainer: some View {
        HStack(spacing: 0) {
            /// 피드백 뷰
            FeedbackChartView(practice: $practice)
            /// 스크립트 뷰
            ScriptView(practice: $practice)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// #Preview {
//    @State
//    var mockHuman = MockHuman(name: "444", ages: 40)
//    
//    return PracticeView(mock: mockHuman)
// }
