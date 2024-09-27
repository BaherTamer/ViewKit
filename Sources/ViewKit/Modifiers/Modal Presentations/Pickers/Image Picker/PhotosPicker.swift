//
//  SwiftUIImagePicker.swift
//  ViewKit
//
//  Created by Baher Tamer on 14/09/2024.
//

import OSLog
import PhotosUI
import SwiftSafeUI
import SwiftUI

@available(iOS 16.0, *)
extension View {
    func photosPicker(isPresented: Binding<Bool>, image: Binding<UIImage?>) -> some View {
        modifier(
            AppPhotosPicker(
                isPresented: isPresented,
                image: image
            )
        )
    }
}

@available(iOS 16.0, *)
fileprivate struct AppPhotosPicker: ViewModifier {
    // MARK: - Inputs
    @Binding var isPresented: Bool
    @Binding var image: UIImage?
    
    // MARK: - Variables
    @State private var selectedItem: PhotosPickerItem? = nil
    private let logger = Logger.photosPicker
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .photosPicker(
                isPresented: $isPresented,
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()
            )
            .safeOnChange(selectedItem, perform: didSelectImage)
    }
    
    // MARK: - Private Helpers
    private func didSelectImage(_ item:  PhotosPickerItem?, _ newItem:  PhotosPickerItem?) {
        if let newItem {
            newItem.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    setImage(data: data)
                case .failure(let error):
                    logger.error("Failed to load image data from photos picker: \(error)")
                }
            }
        }
    }
    
    private func setImage(data: Data?) {
        if let data, let uiImage = UIImage(data: data) {
            image = uiImage
        }
    }
}
