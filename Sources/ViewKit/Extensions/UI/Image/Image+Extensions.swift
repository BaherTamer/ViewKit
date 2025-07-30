//
//  Image+Extensions.swift
//  ViewKit
//
//  Created by Baher Tamer on 12/09/2024.
//

import SwiftUI
import SwiftSafeUI

extension Image {
    ///
    /// Converts a `SwiftUI Image` into a `UIImage`.
    ///
    /// This method uses `ImageRenderer` to render a `SwiftUI Image` into a `UIImage`. It sets the rendering scale to `1.0`, ensuring that the output image maintains its original size without scaling.
    ///
    /// This function is marked with `@MainActor`, indicating that it should be called on the main thread, making it suitable for UI-related operations.
    ///
    /// > Important: This method is available starting from iOS 16.
    ///
    /// - Returns:
    /// An optional `UIImage`.\
    /// It returns a `UIImage` if the rendering is successful; otherwise, it returns `nil`.
    ///
    @MainActor
    @available(iOS 16, *)
    func asUIImage() -> UIImage? {
        let renderer = ImageRenderer(content: self)
        renderer.scale = 1.0
        return renderer.uiImage
    }
}
