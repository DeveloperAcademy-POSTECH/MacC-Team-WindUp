//
//  Color.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/21.
//

import Foundation
import SwiftUI

// swiftlint:disable identifier_name
extension Color {
    struct HPPrimary {
        private init () {}
        static let lightness = Color.primary100
        static let light = Color.primary300
        static let primary = Color.primary500
        static let dark = Color.primary700
        static let darkness = Color.primary900
    }
    
    struct HPSecondary {
        private init () {}
        static let scalet = Color.scalet500
        static let red = Color.red500
        static let orange = Color.orange500
        static let yellow = Color.yellow500
        static let lightgreen = Color.lightgreen500
        static let green = Color.green500
        static let teal = Color.blue500
        static let blue = Color.blue500
        static let deepblue = Color.deepblue500
        static let navy = Color.navy500
        static let lavendar = Color.lavendar500
        static let violet = Color.violet500
        static let purple = Color.purple500
        static let pink = Color.pink500
    }
}

// MARK: - GrayScale
extension Color {
    static let systemWhite = Color("gray0_white")
    static let systemGray100 = Color("gray100")
    static let systemGray200 = Color("gray200")
    static let systemGray300 = Color("gray300")
    static let systemGray400 = Color("gray400")
    static let systemGray500 = Color("gray500")
    static let systemGray600 = Color("gray600")
    static let systemGray700 = Color("gray700")
    static let systemGray800 = Color("gray800")
    static let systemGray900 = Color("gr ay900")
    static let systemBlack = Color("gray1000_black")
}

// MARK: - PrimaryColorScale
extension Color {
    private static let primary100 = Color("primary100")
    private static let primary300 = Color("primary300")
    private static let primary500 = Color("primary500")
    private static let primary700 = Color("primary700")
    private static let primary900 = Color("primary900")
}

extension Color {
    private static let scalet500 = Color("0_scalet500")
    private static let red500 = Color("1_red500")
    private static let orange500 = Color("2_orange500")
    private static let yellow500 = Color("3_yellow500")
    private static let lightgreen500 = Color("4_lightgreen500")
    private static let green500 = Color("5_green500")
    private static let teal500 = Color("6_teal500")
    private static let blue500 = Color("7_blue500")
    private static let deepblue500 = Color("8_deepblue500")
    private static let navy500 = Color("9_navy500")
    private static let lavendar500 = Color("10_lavendar500")
    private static let violet500 = Color("11_violet500")
    private static let purple500 = Color("12_purple500")
    private static let pink500 = Color("13_pink500")
}
// swiftlint:enable identifier_name
