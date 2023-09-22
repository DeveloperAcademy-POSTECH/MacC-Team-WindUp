//
//  Button.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/21.
//

import SwiftUI

struct HPButton: View, StyleEssential, StyledLabelStyleEssential {
    var label: String
    var icon: String?
    var alignStyle: LabelAlignStyle = .textOnly
    var size: HPButtonSize = .medium
    var type: HPButtonType = .blockFill
    var color: Color = .HPPrimary.primary
    var width: CGFloat = .infinity
    var action: () -> Void
    @State private var isHover = false
    var body: some View {
        Button {
            action()
        } label: {
            if let icon = icon {
                HPLabel(
                    label: label,
                    icon: icon,
                    type: .none,
                    color: type.style.fillStyle.isLook(.fill) ? .systemWhite : color,
                    fontStyle: size.font,
                    alignStyle: alignStyle
                )
                .systemFont(size.font, weight: .medium)
            } else {
                HPLabel(
                    label: label,
                    type: .none,
                    color: type.style.fillStyle.isLook(.fill) ? .systemWhite : color,
                    fontStyle: size.font,
                    alignStyle: alignStyle
                )
            }
        }
        .buttonStyle(
            HPButtonStyle(
                size: size,
                type: type,
                color: color)
        )
        .frame(maxWidth: width)
        .onHover { hover in
            withAnimation {
                self.isHover = hover
            }
            
        }
        .scaleEffect(isHover ? 1.007 : 1)
    }
}

// MARK: - Preview
struct HPButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HPButton(label: "Hello") {
                print("Hello2")
            }
            HPButton(
                label: "World!",
                size: .medium,
                type: .blockFill
                
            ) {
                print("World!")
            }
            .frame(maxWidth: .infinity)
            .padding(.HPSpacing.medium)
        }
    }
}

enum HPButtonType {
    case blockFill
    case blockLine
    case blockGhost
    case boxFill
    case boxLine
    case boxGhost
    case roundFill
    case roundLine
    case roundGhost
    case text
}

enum HPButtonSize {
    case xsmall
    case small
    case medium
    case large
    case xlarge
}

extension HPButtonType {
    var style: ComponentStyle {
        switch self {
        case .blockFill:
            return ComponentStyle(outlineStyle: .block, fillStyle: .fill)
        case .blockLine:
            return ComponentStyle(outlineStyle: .block, fillStyle: .line)
        case .blockGhost:
            return ComponentStyle(outlineStyle: .block, fillStyle: .ghost)
        case .boxFill:
            return ComponentStyle(outlineStyle: .box, fillStyle: .fill)
        case .boxLine:
            return ComponentStyle(outlineStyle: .box, fillStyle: .line)
        case .boxGhost:
            return ComponentStyle(outlineStyle: .box, fillStyle: .ghost)
        case .roundFill:
            return ComponentStyle(outlineStyle: .round, fillStyle: .fill)
        case .roundLine:
            return ComponentStyle(outlineStyle: .round, fillStyle: .line)
        case .roundGhost:
            return ComponentStyle(outlineStyle: .round, fillStyle: .ghost)
        case .text:
            return ComponentStyle(outlineStyle: .text, fillStyle: .text)
        }
    }
}

extension HPButtonSize {
    var rawValue: CGFloat {
        switch self {
        case .xsmall:
            return FoundationSpaceFrame.xsmall.rawValue
        case .small:
            return FoundationSpaceFrame.small.rawValue
        case .medium:
            return FoundationSpaceFrame.medium.rawValue
        case .large:
            return FoundationSpaceFrame.large.rawValue
        case .xlarge:
            return FoundationSpaceFrame.xlarge.rawValue
        }
    }
    
    var font: FoundationTypoSystemFont {
        switch self {
        case .xsmall:
            return .caption1
        case .small:
            return .caption1
        case .medium:
            return .caption1
        case .large:
            return .body
        case .xlarge:
            return .body
        }
    }
}

struct HPButtonStyle: ButtonStyle, StyleEssential {
    var size: HPButtonSize
    var type: HPButtonType
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        HPButtonContent(configuration: configuration, type: type, color: color, size: size)
    }
}

struct HPButtonContent: View, StyleConfiguration {
    var configuration: ButtonStyleConfiguration
    var type: HPButtonType
    var color: Color
    var size: HPButtonSize
    
    var body: some View {
        configuration.label
            .systemFont(size.font, weight: .medium)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, minHeight: size.rawValue)
            .background(
                type.style.fillStyle.isLook(.fill)
                ? color
                : .clear)
            .foregroundColor(
                type.style.fillStyle.isLook(.fill)
                ? .systemWhite
                : color
            )
            .cornerRadius(type.style.outlineStyle.isLook(.block)
                          ? .HPCornerRadius.large
                          : type.style.outlineStyle.isLook(.round)
                          ? .HPCornerRadius.round
                          : 0)
            .overlay(
                RoundedRectangle(
                    cornerRadius: type.style.outlineStyle.isLook(.block)
                    ? .HPCornerRadius.large
                    : type.style.outlineStyle.isLook(.round)
                    ? .HPCornerRadius.round
                    : 0)
                .stroke(
                    type.style.fillStyle.isLook(.ghost) || type.style.fillStyle.isLook(.text)
                    ? .clear
                    : color, lineWidth: 3)
                .cornerRadius(type.style.outlineStyle.isLook(.block)
                              ? .HPCornerRadius.large
                              : type.style.outlineStyle.isLook(.round)
                              ? .HPCornerRadius.round
                              : 0)
            )
    }
}
