//
//  HomeView.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/20.
//

import SwiftUI

enum Route {
    case view1
    case view2
}

struct HomeView: View {
    @StateObject var vm = HomeVM()
    @State private var isModalActive = false
    @State private var navigationPath: [Route] = []
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(alignment: .leading, spacing: 0) {
                projectLogoView()
                newProjectViewContainer()
                hasProjectListViewContainer()
            }
            .padding(.top, 68)
            .padding(.horizontal, 128)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .navigationDestination(for: Route.self, destination: { route in
                switch route {
                case .view1:
                    ProjectView(navigationPath: $navigationPath)
                        .toolbar(.hidden, for: .automatic)
                case  .view2:
                    PresentationView(navigationPath: $navigationPath)
                        .toolbar(.hidden, for: .automatic)
                }
            })
            .sheet(isPresented: $isModalActive, content: {
                Text("HH")
            })
            .onAppear {
                vm.updateProjects()
            }
        }
        .frame(
            minWidth: 960,
            maxWidth: .infinity,
            minHeight: 640,
            maxHeight: .infinity,
            alignment: .topLeading
        )

    }
}

extension HomeView {
    // MARK: - projectLogoView
    private func projectLogoView() -> some View {
        Image(.SystemImage.mainLogo.rawValue)
            .resizable()
            .scaledToFit()
            .frame(height: 35)
            .padding(.bottom, 20)
    }
    // MARK: - newProjectView
    private func newProjectViewContainer() -> some View {
        VStack(alignment: .leading) {
            // TextContainer
            VStack(alignment: .leading, spacing: 12) {
                Text("새 프로젝트")
                    .systemFont(.headline)
                Text("새 프로젝트를 추가해서 제작해보세요")
                    .systemFont(.body)
                    .foregroundColor(.systemGray600)
            }
            VStack(spacing: 20) {
                Image(systemName: SFSymbols.addProject.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 84, height: 68)
                    .foregroundColor(.systemGray500)
                HPButton(
                    label: "프로젝트 생성하기",
                    size: .large,
                    width: 180
                ) {
                    isModalActive.toggle()
                }
            }
            .padding(.bottom, 68)
            .frame(maxWidth: .infinity)
        }
        .frame(alignment: .topLeading)
        .border(width: 1,
                edges: [.bottom],
                color: .systemGray400
        )
    }
    
    // MARK: - hasProjectListiew
    private func hasProjectListViewContainer() -> some View {
        VStack(alignment: .leading) {
            Text("이전 프로젝트")
                .systemFont(.headline)
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
                                ForEach(0...20, id: \.self) { _ in
                                    VStack(alignment: .leading) {
                                        projectCard(itemWidth: itemWidth)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .onTapGesture {
//                                        isProjectOpen.toggle()
                                        navigationPath.append(.view1)
                                    }
                                }
                            }
                            .padding(.bottom, 68)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 68)
        .frame(alignment: .topLeading)
    }
    
    private func projectCard(itemWidth: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            if let project = vm.projects.first {
                ZStack {
                    AsyncImage(url: project.thumbnail) { phase in
                        phase.image?.resizable().scaledToFit()
                    }
                }
                .frame(maxWidth: .infinity, minHeight: itemWidth / 16 * 9)
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.systemGray400)
                )
                .cornerRadius(10)
                VStack(alignment: .leading, spacing: 0) {
                    Text(project.projectName)
                        .systemFont(.body)
                        .lineLimit(1)
                    Text(project.createAt.description)
                        .systemFont(.caption2)
                        .foregroundColor(.systemGray500)
                        .lineLimit(1)
                }
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            HomeView()
//        }
//    }
//}
