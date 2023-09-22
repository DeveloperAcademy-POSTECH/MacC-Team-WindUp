//
//  Space.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/21.
//

import Foundation
import SwiftUI

enum FoundationSpaceRaduis: CGFloat {
    case xxsmall = 2.0
    case xsmall = 4.0
    case small = 6.0
    case medium = 8.0
    case large = 12.0
    case xlarge = 16.0
    case xxlarge = 20.0
    case xxxlarge = 24.0
    case round = 100.0
}

enum FoundationSpaceSpacing: CGFloat {
    case xxsmall = 4.0
    case xsmall = 8.0
    case small = 12.0
    case medium = 16.0
    case large = 20.0
    case xlarge = 24.0
    case xxlarge = 32.0
    case xxxlarge = 40.0
}

enum FoundationSpaceFrame: CGFloat {
    case xxsmall = 24.0
    case xsmall = 28.0
    case small = 32.0
    case medium = 36.0
    case large = 40.0
    case xlarge = 48.0
    case xxlarge = 54.0
}

enum ComponentSpaceSpacing: CGFloat {
    case small = 2.0
    case medium = 4.0
    case large = 8.0
}

extension CGFloat {
    struct HPCornerRadius {
        // MARK: - CornerRadius
        private init() {}
        /// rawValue: 2.0
        static let xxsmall = FoundationSpaceRaduis.xxsmall.rawValue
        /// rawValue: 4.0
        static let xsmall = FoundationSpaceRaduis.xsmall.rawValue
        /// rawValue: 6.0
        static let small = FoundationSpaceRaduis.small.rawValue
        /// rawValue: 8.0
        static let medium = FoundationSpaceRaduis.medium.rawValue
        /// rawValue: 12.0
        static let large = FoundationSpaceRaduis.large.rawValue
        /// rawValue: 16.0
        static let xlarge = FoundationSpaceRaduis.xlarge.rawValue
        /// rawValue: 20.0
        static let xxlarge = FoundationSpaceRaduis.xxlarge.rawValue
        /// rawValue: 24.0
        static let xxxlarge = FoundationSpaceRaduis.xxxlarge.rawValue
        /// rawValue: 100.0
        static let round = FoundationSpaceRaduis.round.rawValue
    }
}

extension CGFloat {
    // MARK: - Spacing
    struct HPSpacing {
        private init() {}
        /// rawValue: 4.0
        static let xxsmall = FoundationSpaceSpacing.xxsmall.rawValue
        /// rawValue: 8.0
        static let xsmall = FoundationSpaceSpacing.xsmall.rawValue
        /// rawValue: 12.0
        static let small = FoundationSpaceSpacing.small.rawValue
        /// rawValue: 16.0
        static let medium = FoundationSpaceSpacing.medium.rawValue
        /// rawValue: 20.0
        static let large = FoundationSpaceSpacing.large.rawValue
        /// rawValue: 24.0
        static let xlarge = FoundationSpaceSpacing.xlarge.rawValue
        /// rawValue: 32.0
        static let xxlarge = FoundationSpaceSpacing.xxlarge.rawValue
        /// rawValue: 40.0
        static let xxxlarge = FoundationSpaceSpacing.xxxlarge.rawValue
    }
}

extension CGFloat {
    struct HPFrame {
        // MARK: - Frame
        private init() {}
        /// rawValue: 24.0
        static let xxsmall = FoundationSpaceFrame.xxsmall.rawValue
        /// rawValue: 28.0
        static let xsmall = FoundationSpaceFrame.xsmall.rawValue
        /// rawValue: 32.0
        static let small = FoundationSpaceFrame.small.rawValue
        /// rawValue: 36.0
        static let medium = FoundationSpaceFrame.medium.rawValue
        /// rawValue: 40.0
        static let large = FoundationSpaceFrame.large.rawValue
        /// rawValue: 48.0
        static let xlarge = FoundationSpaceFrame.xlarge.rawValue
        /// rawValue: 54.0
        static let xxlarge = FoundationSpaceFrame.xxlarge.rawValue
    }
}

extension CGFloat {
    // MARK: - CFComponentSpacing
    struct HPCompoentSpacing {
        private init() {}
        /// rawValue: 2.0
        static let small = ComponentSpaceSpacing.small.rawValue
        /// rawValue: 4.0
        static let medium = ComponentSpaceSpacing.medium.rawValue
        /// rawValue: 8.0
        static let large = ComponentSpaceSpacing.large.rawValue
    }
}
