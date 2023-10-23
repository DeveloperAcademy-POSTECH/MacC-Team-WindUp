//
//  MainWindowView.swift
//  highpitch
//
//  Created by yuncoffee on 10/10/23.
//

#if os(macOS)
import SwiftUI
import SwiftData

struct MainWindowView: View {
    // MARK: - 데이터 컨트롤을 위한 매니저 객체
    @Environment(FileSystemManager.self)
    private var fileSystemManager
    @Environment(KeynoteManager.self)
    private var keynoteManager
    @Environment(MediaManager.self)
    private var mediaManager
    @Environment(ProjectManager.self)
    private var projectManager
    
    // MARK: - 데이터 저장을 위한 컨텍스트 객체
    @Environment(\.modelContext)
    var modelContext
    @Query(sort: \ProjectModel.creatAt)
    var projects: [ProjectModel]
    
    @State
    private var columnVisibility = NavigationSplitViewVisibility.detailOnly
    
    private var selected: ProjectModel? {
        projectManager.current
    }
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            navigationSidebar
        } detail: {
            navigationDetails
        }
        .toolbarBackground(.hidden)
        .navigationTitle("Sidebar")
        .frame(minWidth: 1000, minHeight: 600)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.HPComponent.mainWindowSidebarBackground)
        .onAppear {
//            do {
//                try modelContext.delete(model: ProjectModel.self)
//                try modelContext.delete(model: PracticeModel.self)
//                try modelContext.delete(model: UtteranceModel.self)
//                try modelContext.delete(model: WordModel.self)
//                try modelContext.delete(model: SentenceModel.self)
//                try modelContext.delete(model: PracticeSummaryModel.self)
//                try modelContext.delete(model: FillerWordModel.self)
//            } catch {
//                print("Failed to clear all ProjectModel data")
//            }
            setup()
        }
    }
}

extension MainWindowView {
    private func setup() {
//        쿼리해온 데이터에서 맨 앞 데이터 선택
        if !projects.isEmpty {
            projectManager.projects = projects
            projectManager.current = projects[0]
        }
    }
}

// MARK: - Views

extension MainWindowView {
    // MARK: - navigationSidebar
    @ViewBuilder
    var navigationSidebar: some View {
        LazyVGrid(columns: [GridItem()], alignment: .leading) {
            ProjectNavigationLink()
        }
        .padding(.top, .HPSpacing.medium)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.HPComponent.mainWindowSidebarBackground)
        .navigationSplitViewColumnWidth(200)
    }
    
    // MARK: - navigationDetails
    @ViewBuilder
    var navigationDetails: some View {
        if selected != nil {
            VStack(alignment: .leading, spacing: 0) {
                projectToolbar
                VStack {
                    ProjectView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.HPComponent.mainWindowDetailsBackground)
            .ignoresSafeArea()
        } else {
            emptyProject
        }
    }
    
    // MARK: - emptyProject
    @ViewBuilder
    var emptyProject: some View {
        VStack {
            Text("선택된 프로젝트가 없습니다.")
        }
    }
    
    // MARK: - projectToolbar
    @ViewBuilder
    var projectToolbar: some View {
        if let projectName = projectManager.current?.projectName {
            HPTopToolbar(title: projectName)
        }
    }
}

#Preview {
    MainWindowView()
        .environment(FileSystemManager())
        .environment(MediaManager())
        .environment(KeynoteManager())
        .environment(ProjectManager())
}
#endif
