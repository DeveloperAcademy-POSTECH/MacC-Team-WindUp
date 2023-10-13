//
//  App.swift
//  highpitch
//
//  Created by yuncoffee on 10/10/23.
//

import SwiftUI
import SwiftData

@main
struct HighpitchApp: App {
    @State private var mediaManager = MediaManager()
    #if os(macOS)
    @State private var appleScriptManager = AppleScriptManager()
    @State private var keynoteManager = KeynoteManager()
    #endif
    // MARK: - SwiftData
    let container: ModelContainer
    
    var body: some Scene {
        #if os(iOS)
        WindowGroup {
            VStack(content: {
                Text("Placeholder")
            })
        }
        #endif
        #if os(macOS)
        WindowGroup {
            MainWindowView()
                .environment(appleScriptManager)
                .environment(mediaManager)
                .environment(keynoteManager)
                
        }
        .modelContainer(container)
        .defaultSize(width: 1000, height: 600)
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentMinSize)
        #endif
        #if os(macOS)
        Settings {
            SettingsView()
                .environment(appleScriptManager)
                .environment(mediaManager)
                .environment(keynoteManager)
        }
        .modelContainer(container)
        
        MenuBarExtra("MenubarExtra", systemImage: "heart") {
            MenubarExtraView()
                .environment(appleScriptManager)
                .environment(mediaManager)
                .environment(keynoteManager)
        }
        .modelContainer(container)
        #endif
    }
    
    init() {
        do {
            container = try ModelContainer(for: Sample.self)
        } catch {
            fatalError("Failed to create ModelContainer for Sample")
        }
        setupInit()
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
