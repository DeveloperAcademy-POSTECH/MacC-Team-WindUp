//
//  SystemFont.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/21.
//

import Foundation
import SwiftUI

extension View {
    func systemFont(
        _ style: FoundationTypoSystemFont,
        weight: FoundationTypoSystemFont.FontWeight? = nil) -> some View {
        modifier(HPSystemFontModifier(style: style, weight: weight))
    }
}

struct HPSystemFontModifier: ViewModifier {
    var style: FoundationTypoSystemFont
    var weight: FoundationTypoSystemFont.FontWeight?
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(
                weight?.fontName ?? style.fontWeight.fontName,
                size: style.fontSize,
                relativeTo: style.relateTo)
            )
            .lineSpacing(style.lineHeight)
    }
}

enum FoundationTypoSystemFont {
//    case largeTtile
//    case title
    case headline
    case subTitle
//    case subHeadline
    case body
//    case footnote
    case caption1
    case caption2
}

extension FoundationTypoSystemFont {
    enum FontWeight {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black
    }
}

extension FoundationTypoSystemFont {
    var fontSize: CGFloat {
        switch self {
        case .headline:
            return 24
        case .subTitle:
            return 18
        case .body:
            return 16
        case .caption1:
            return 14
        case .caption2:
            return 12
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .headline:
            return (32 - self.fontSize) / 2
        case .subTitle:
            return (27 - self.fontSize) / 2
        case .body:
            return (24 - self.fontSize) / 2
        case .caption1:
            return (16.8 - self.fontSize) / 2
        case .caption2:
            return (16.8 - self.fontSize) / 2
        }
    }
    
    var fontWeight: FoundationTypoSystemFont.FontWeight {
        switch self {
        case .headline:
            return .bold
        case .subTitle:
            return .semibold
        case .body:
            return .medium
        case .caption1:
            return .regular
        case .caption2:
            return .regular
        }
    }
    
    var relateTo: Font.TextStyle {
        switch self {
        case .headline:
            return .title3
        case .subTitle:
            return .headline
        case .body:
            return .body
        case .caption1:
            return .caption
        case .caption2:
            return .caption2
        }
    }
}

extension FoundationTypoSystemFont.FontWeight {
    var fontName: String {
        switch self {
        case .ultraLight:
            return "Pretendard-Thin"
        case .thin:
            return "Pretendard-ExtraLight"
        case .light:
            return "Pretendard-Light"
        case .regular:
            return "Pretendard-Regular"
        case .medium:
            return "Pretendard-Medium"
        case .semibold:
            return "Pretendard-SemiBold"
        case .bold:
            return "Pretendard-Bold"
        case .heavy:
            return "Pretendard-ExtraBold"
        case .black:
            return "Pretendard-Black"
        }
    }
}
