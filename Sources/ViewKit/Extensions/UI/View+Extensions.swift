//
//  View+Extensions.swift
//  ViewKit
//
//  Created by Baher Tamer on 11/09/2024.
//

import SwiftUI
import SwiftSafeUI

extension View {
    /// A Boolean value that indicates whether the current user interface layout direction is right-to-left.
    public var isRTL: Bool {
        UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}
