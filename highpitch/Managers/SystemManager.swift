//
//  SystemManager.swift
//  highpitch
//
//  Created by yuncoffee on 11/2/23.
//

import Foundation

@Observable
final class SystemManager {
    private init() {}
    static let shared = SystemManager()
    var isDarkMode = false
    var isAnalyzing = false
    var hasUnVisited = false
}
