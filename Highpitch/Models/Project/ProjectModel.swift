//
//  Project.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/20.
//

import Foundation

enum WrongIntervalType {
    case fast
    case slow
}

typealias WrongInterval = (type: WrongIntervalType, offset: CGFloat)

protocol Practiceable {
    var audioPath: URL {get}
    var createAt: Date {get}
    var wrongIntervals: [WrongInterval]? {get set}
}

struct Practice: Practiceable, Identifiable {
    var id: UUID = UUID()
    var audioPath: URL
    var createAt: Date
    var wrongIntervals: [WrongInterval]?
}

protocol HPProjectable {
    var projectName: String {get set}
    var createAt: Date {get}
    var presentationPath: URL {get}
    var thumbnail: URL? {get set}
    var practices: [Practice]? {get set}
}

struct HPProject: HPProjectable, Identifiable {
    var id: UUID = UUID()
    var projectName: String
    var createAt: Date
    var presentationPath: URL
    var thumbnail: URL? = Bundle.main.url(
        forResource: .SystemImage.emptyProjectThumbnail.rawValue,
        withExtension: "png")
    var practices: [Practice]?
}
