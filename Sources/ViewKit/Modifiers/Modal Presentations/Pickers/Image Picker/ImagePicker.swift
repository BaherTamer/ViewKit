//
//  ImagePicker.swift
//  ViewKit
//
//  Created by Baher Tamer on 14/09/2024.
//

import SwiftUI

extension View {
    ///
    /// Presents an image picker for selecting an image from the photo library..
    ///
    /// This function enables the display of an image picker that allows users to choose an image.
    ///
    /// It adapts to the iOS version, using `SwiftUI` native photo picker for iOS 16 and above, while falling back to a standard `PHPickerViewController` for earlier versions.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a `Bool` value that determines whether to present the image picker.
    ///   - image: A binding to an optional `UIImage` where the selected image will be stored.
    ///
    /// - Returns: A `some` `View` that represents the modified view with the image picker functionality applied.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ContentView: View {
    ///     @State private var isImagePickerPresented = false
    ///     @State private var selectedImage: UIImage?
    ///
    ///     var body: some View {
    ///         Button("Select Image") {
    ///             isImagePickerPresented = true
    ///         }
    ///         .imagePicker(
    ///             isPresented: $isImagePickerPresented,
    ///             image: $selectedImage
    ///         )
    ///     }
    /// }
    /// ```
    ///
    public func imagePicker(
        isPresented: Binding<Bool>,
        image: Binding<UIImage?>
    ) -> some View {
        modifier(
            ImagePicker(
                isPresented: isPresented,
                image: image
            )
        )
    }
}

fileprivate struct ImagePicker: ViewModifier {
    // MARK: - Inputs
    @Binding var isPresented: Bool
    @Binding var image: UIImage?
    
    // MARK: - Body
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .photosPicker(
                    isPresented: $isPresented,
                    image: $image
                )
        } else {
            content
                .sheet(isPresented: $isPresented) {
                    UIImagePicker(image: $image)
                        .ignoresSafeArea()
                }
        }
    }
}
