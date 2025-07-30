//
//  Color+Extensions.swift
//  ViewKit
//
//  Created by Baher Tamer on 11/09/2024.
//

import SwiftUI
import SwiftSafeUI

extension Color {
    /// Converts a SwiftUI `Color` to a `UIColor`.
    public var asUIColor: UIColor { .init(self) }
}
