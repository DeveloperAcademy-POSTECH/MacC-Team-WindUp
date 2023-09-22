//
//  HPLabel.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/21.
//

import SwiftUI

protocol StyledLabelStyleEssential {
    var alignStyle: LabelAlignStyle { get }
}

struct HPLabel: View, StyleEssential, StyledLabelStyleEssential {
    var label: String
    var icon: String = "plus.square.fill"
    var type: LabelType = .blockFill
    var size: LabelSize = .small
    var color: Color = .HPSecondary.orange
    var fontStyle: FoundationTypoSystemFont = .caption1
    var alignStyle: LabelAlignStyle = .textOnly

    var body: some View {
        Label(label, systemImage: icon)
            .labelStyle(HPLabelStyle(
                type: type,
                size: size,
                color: color,
                alignStyle: alignStyle
            )
        )
        .systemFont(fontStyle)
    }
}

struct HPLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
    }
}

enum LabelAlignStyle {
    case iconWithText
    case textWithIcon
    case iconOnly
    case textOnly
    case iconWithTextVertical
}

enum LabelType {
    case blockFill
    case blockLine
    case boxFill
    case boxLine
    case roundFill
    case roundLine
    case text
    case none
}

enum LabelSize {
    case xsmall
    case small
    case medium
    case large
    case xlarge
}

extension LabelType {
    var style: ComponentStyle? {
        switch self {
        case .blockFill:
            return ComponentStyle(outlineStyle: .block, fillStyle: .fill)
        case .blockLine:
            return ComponentStyle(outlineStyle: .block, fillStyle: .line)
        case .boxFill:
            return ComponentStyle(outlineStyle: .box, fillStyle: .fill)
        case .boxLine:
            return ComponentStyle(outlineStyle: .box, fillStyle: .line)
        case .roundFill:
            return ComponentStyle(outlineStyle: .round, fillStyle: .fill)
        case .roundLine:
            return ComponentStyle(outlineStyle: .round, fillStyle: .line)
        case .text:
            return ComponentStyle(outlineStyle: .text, fillStyle: .text)
        case .none:
            return nil
        }
    }
}

extension LabelSize {
    var rawValue: CGFloat {
        switch self {
        case .xsmall:
            return 18
        case .small:
            return 20
        case .medium:
            return 26
        case .large:
            return 28
        case .xlarge:
            return 32
        }
    }
}

struct HPLabelStyle: LabelStyle, StyleEssential, StyledLabelStyleEssential {
    var type: LabelType
    var size: LabelSize
    var color: Color
    var alignStyle: LabelAlignStyle
    
    func makeBody(configuration: Configuration) -> some View {
        if type == .none {
            HPLabelContent(
                configuration: configuration,
                type: type,
                size: size,
                color: color,
                alignStyle: alignStyle
            )
            .foregroundColor(color)
            .frame(minHeight: size.rawValue)
        } else {
            if let style = type.style {
                HPLabelContent(
                    configuration: configuration,
                    type: type,
                    size: size,
                    color: color,
                    alignStyle: alignStyle
                )
                .padding(.horizontal, .HPSpacing.xsmall)
                .padding(.vertical, .HPSpacing.xxsmall)
                .frame(minWidth: size.rawValue * 1.5, minHeight: size.rawValue)
                .background(
                    style.fillStyle.isLook(.fill)
                    ? color
                    : .clear)
                .foregroundColor(
                    style.fillStyle.isLook(.fill)
                    ? .systemWhite
                    : color
                )
                .cornerRadius(style.outlineStyle.isLook(.block)
                              ? .HPCornerRadius.xsmall
                              : style.outlineStyle.isLook(.round)
                              ? .HPCornerRadius.round
                              : 0)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: style.outlineStyle.isLook(.block)
                        ? .HPCornerRadius.xsmall
                        : style.outlineStyle.isLook(.round)
                        ? .HPCornerRadius.round
                        : 0)
                    .stroke(
                        style.fillStyle.isLook(.text)
                        ? .clear
                        : color, lineWidth: 3)
                    .cornerRadius(style.outlineStyle.isLook(.block)
                                  ? .HPCornerRadius.xsmall
                                  : style.outlineStyle.isLook(.round)
                                  ? .HPCornerRadius.round
                                  : 0)
                )
            }
        }
    }
}

struct HPLabelContent: View, StyleConfiguration, StyledLabelStyleEssential {
    var configuration: LabelStyleConfiguration
    var type: LabelType
    var size: LabelSize
    var color: Color
    var alignStyle: LabelAlignStyle
    
    var body: some View {
        if alignStyle == .iconWithTextVertical {
            VStack(spacing: .HPCompoentSpacing.small) {
                configuration.icon
                configuration.title
            }
        } else if alignStyle == .iconOnly {
            configuration.icon
        } else if alignStyle == .textWithIcon {
            HStack(spacing: .HPCompoentSpacing.small) {
                configuration.title
                configuration.icon
            }
        } else if alignStyle == .iconWithText {
            HStack(spacing: .HPCompoentSpacing.small) {
                configuration.icon
                configuration.title
            }
        } else {
            configuration.title
        }
    }
}
