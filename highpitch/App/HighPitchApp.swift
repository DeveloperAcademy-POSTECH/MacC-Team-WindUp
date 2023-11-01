//
//  App.swift
//  highpitch
//
//  Created by yuncoffee on 10/10/23.
//

import SwiftUI
import SwiftData
import MenuBarExtraAccess
import SettingsAccess

@main
struct HighpitchApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openWindow) var openWindow
    
    // MARK: - 데이터 컨트롤을 위한 매니저 객체 선언(전역 싱글 인스턴스)
    @State
    private var fileSystemManager = FileSystemManager()
    @State
    private var mediaManager = MediaManager()
    @State 
    private var projectManager = ProjectManager()
    #if os(macOS)
    @State 
    private var appleScriptManager = AppleScriptManager()
    @State 
    private var keynoteManager = KeynoteManager()
    @State
    private var practiceManager = PracticeManager()
    @State
    private var isMenuPresented: Bool = false

    @State
    var refreshable = false
    
    #endif
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: ProjectModel.self, configurations: ModelConfiguration())
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }

    var body: some Scene {
        #if os(macOS)
        // MARK: - MainWindow Scene
        Window("mainwindow", id: "main") {
            MainWindowView()
                .environment(appleScriptManager)
                .environment(fileSystemManager)
                .environment(keynoteManager)
                .environment(mediaManager)
                .environment(projectManager)
                .modelContainer(container)
        }
        .defaultSize(width: 1080, height: 600)
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        // MARK: - Settings Scene
        Settings {
            SettingsView()
                .environment(appleScriptManager)
                .environment(keynoteManager)
                .environment(mediaManager)
                .modelContainer(container)
                .onAppear(perform: {
                    print("On..!")
                })
        }
        // MARK: - MenubarExtra Scene
        MenuBarExtra {
            MenubarExtraView(refreshable: $refreshable)
                .environment(appleScriptManager)
                .environment(fileSystemManager)
                .environment(keynoteManager)
                .environment(mediaManager)
                .environment(projectManager)
                .openSettingsAccess()
                .modelContainer(container)
                .introspectMenuBarExtraWindow { window in
                    window.animationBehavior = .utilityWindow
                }
                .onAppear(perform: {
                    practiceManager.isAnalyzing = false
                })
        } label: {
            Label("MenubarExtra", image : .menubarextra)
        }
        .onChange(of: isMenuPresented, { _, newValue in
            refreshable = newValue
        })
        .menuBarExtraStyle(.window)
        .commandsRemoved()
        #endif
    }
    func updateWeatherData() async {
            // fetches new weather data and updates app state
        }
}
extension HighpitchApp {
    private func setupInit() {
        #if os(macOS)
        Task {
            let result = await appleScriptManager.runScript(.isActiveKeynoteApp)
            if case .boolResult(let isKeynoteOpen) = result {
                // logic 1
                if isKeynoteOpen {
                    print("열려있습니다")
                } else {
                    print("닫혀있습니다")
                }
            }
        }
        #endif
    }
}
