//
//  Base64Image.swift
//  ViewKit
//
//  Created by Baher Tamer on 12/09/2024.
//

import SwiftUI
import SwiftSafeUI

extension Image {
    ///
    /// Initializes an `Image` from a Base64-encoded string.
    ///
    /// This failable initializer attempts to create an `Image` instance using a Base64-encoded string representation of image data.
    ///
    /// It first decodes the Base64 string into `Data`. If the decoding fails or if the resulting `Data` cannot be converted into a valid `UIImage`, the initializer returns `nil`.
    ///
    /// This initializer is useful for scenarios where image data is transmitted or stored in a Base64 format, such as in `JSON` responses or certain APIs.
    ///
    /// > Important: Ensure that the provided Base64 string is valid and correctly represents an image format. Invalid or improperly formatted strings will result in `nil`.
    ///
    /// - Parameters:
    ///   - base64String: A `String` containing the Base64-encoded representation of the image data.
    ///
    public init?(base64String: String) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        guard let uiImage = UIImage(data: data) else { return nil }
        self = Image(uiImage: uiImage)
    }
}
