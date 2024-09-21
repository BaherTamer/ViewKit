//
//  CachedAsyncImage.swift
//  ViewKit
//
//  Created by Baher Tamer on 11/09/2024.
//

import SwiftUI

public struct CachedAsyncImage: View {
    // MARK: - Inputs
    private let urlString: String?
    private let contentMode: ContentMode
    
    // MARK: - Variables
    private var imageURL: URL? {
        URL(string: urlString ?? "")
    }
    
    // MARK: - Life Cycle
    ///
    /// Creates a view that loads and caches an image asynchronously from a given URL, with the option to specify its content mode.
    ///
    /// > Important: If the `urlString` is nil or the image failed to fetch, a placeholder image will be displayed.
    ///
    /// > Tip: Placeholder image can be configured using `ViewKitConfig.shared.placeholderImage`.
    ///
    /// - Parameters:
    ///   - urlString: An optional `String` representing the URL of the image to be loaded.
    ///   - contentMode: The `ContentMode` that defines how the image is scaled and positioned within it's frame.
    ///
    public init(urlString: String?, contentMode: ContentMode) {
        self.urlString = urlString
        self.contentMode = contentMode
    }
    
    // MARK: - Body
    public var body: some View {
        if let imageURL {
            image(with: imageURL)
        } else {
            placeholderImage
        }
    }
}

// MARK: - Components
extension CachedAsyncImage {
    @MainActor
    @ViewBuilder
    private func image(with url: URL) -> some View {
        if let cachedImage = ImageCache[url] {
            loadImage(cachedImage)
        } else {
            asyncImage(url: url)
        }
    }
    
    @MainActor
    private func asyncImage(url: URL) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                loadAsyncImage(image, with: url)
            case .failure(_):
                placeholderImage
            default:
                progressView
            }
        }
    }
    
    @MainActor
    private func loadAsyncImage(_ image: Image, with url: URL) -> some View {
        ImageCache[url] = image
        return loadImage(image)
    }
    
    private func loadImage(_ fetchedImage: Image) -> some View {
        fetchedImage
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }
    
    private var placeholderImage: some View {
        ViewKitConfig.shared.placeholderImage
            .resizable()
            .scaledToFill()
    }
    
    private var progressView: some View {
        placeholderImage // This used for resizable modifier
            .overlay(.white)
            .overlay { ProgressView() }
    }
}
