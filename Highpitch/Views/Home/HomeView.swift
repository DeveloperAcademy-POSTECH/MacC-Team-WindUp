//
//  HomeView.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/20.
//

import SwiftUI

struct HomeView: View {
    @State var views = ["발표 연습하기", "연습 기록보기"]
    @State var isProjectOpen = false
    @State var sidebarStatus = 0
    
    var body: some View {
        HStack(spacing: 0) {
            List(0...1, id: \.self) { index in
                Text(views[index])
                    .onTapGesture {
                        sidebarStatus = index
                    }
            }
            .frame(width: 172)
            if sidebarStatus == 0 {
                VStack(alignment: .leading) {
                    // logo
                    Image(.SystemImage.mainLogo.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35)
                    // new project
                    VStack(alignment: .leading) {
                        Text("새 프로젝트")
                            .font(.largeTitle)
                        Text("새 프로젝트를 추가해서 제작해보세요")
                        VStack {
                            Image(systemName: "folder.badge.plus")
                            Button {
                                print("프로젝트 생성..!")
                            } label: {
                                Text("프로젝트 생성하기")
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(alignment: .topLeading)
                    .border(.red)
                    // prev project
                    VStack(alignment: .leading) {
                        Text("이전 프로젝트")
                            .font(.largeTitle)
                        VStack {
                            GeometryReader { geometry in
                                let containerWidth = geometry.size.width
                                let itemWidth = (containerWidth - 56 * 3) / 4
                                
                                ScrollView {
                                    LazyVGrid(
                                        columns: [
                                            GridItem(.flexible(minimum: itemWidth), spacing: 56),
                                            GridItem(.flexible(minimum: itemWidth), spacing: 56),
                                            GridItem(.flexible(minimum: itemWidth), spacing: 56),
                                            GridItem(.flexible(minimum: itemWidth), spacing: 56)
                                        ], spacing: 40) {
                                            ForEach(0...20, id: \.self) { index in
                                                VStack(alignment: .leading) {
                                                    ZStack {
                                                        Image(.SystemImage.mainLogo.rawValue)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 100)
                                                    }
                                                    .frame(maxWidth: .infinity, minHeight: itemWidth / 16 * 9)
                                                    .background(Color.black)
                                                    Text("프로젝트 샘플 - \(index + 1) - \(itemWidth)")
                                                        .font(.body)
                                                        .lineLimit(1)
                                                    Text("\(Date().description)")
                                                        .font(.footnote)
                                                        .lineLimit(1)
                                                }
                                                .frame(
                                                    maxWidth: .infinity
                                                )
                                                .border(.red)
                                                .onTapGesture {
                                                    sidebarStatus = 0
                                                    isProjectOpen.toggle()
                                                }
                                            }
                                        }
                                }
                            }
      
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(alignment: .topLeading)
                    .border(.red)
                }
                .padding(.top, 68)
                .padding(.horizontal, 128)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
            } else {
                VStack(alignment: .leading) {
                    // logo
                    Image(.SystemImage.mainLogo.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35)
                    // new project
                    VStack(alignment: .leading) {
                        Text("연습 기록보기")
                            .font(.largeTitle)
                        Text("연습 기록을 볼 프로젝트를 선택해주세요.")
                    }
                    .frame(alignment: .topLeading)
                    .border(.red)
                    // prev project
                    VStack {
                        GeometryReader { geometry in
                            let containerWidth = geometry.size.width
                            let itemWidth = (containerWidth - 56 * 3) / 4
                            
                            ScrollView {
                                LazyVGrid(
                                    columns: [
                                        GridItem(.flexible(minimum: itemWidth), spacing: 56),
                                        GridItem(.flexible(minimum: itemWidth), spacing: 56),
                                        GridItem(.flexible(minimum: itemWidth), spacing: 56),
                                        GridItem(.flexible(minimum: itemWidth), spacing: 56)
                                    ], spacing: 40) {
                                        ForEach(0...20, id: \.self) { index in
                                            VStack(alignment: .leading) {
                                                ZStack {
                                                    Image(.SystemImage.mainLogo.rawValue)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 100)
                                                }
                                                .frame(maxWidth: .infinity, minHeight: itemWidth / 16 * 9)
                                                .background(Color.black)
                                                Text("프로젝트 샘플 - \(index + 1) - \(itemWidth)")
                                                    .font(.body)
                                                    .lineLimit(1)
                                                Text("\(Date().description)")
                                                    .font(.footnote)
                                                    .lineLimit(1)
                                            }
                                            .frame(
                                                maxWidth: .infinity
                                            )
                                            .border(.red)
                                            .onTapGesture {
                                                sidebarStatus = 1
                                                isProjectOpen.toggle()
                                            }
                                        }
                                    }
                            }
                        }
  
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, 68)
                .padding(.horizontal, 128)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
            }

        }
        .frame(
            minWidth: 960,
            maxWidth: .infinity,
            minHeight: 640,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .navigationDestination(isPresented: $isProjectOpen) {
            ProjectView(sidebarStatus: $sidebarStatus)
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}
