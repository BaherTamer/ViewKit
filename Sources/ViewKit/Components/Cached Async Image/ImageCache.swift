//
//  ImageCache.swift
//  ViewKit
//
//  Created by Baher Tamer on 11/09/2024.
//

import SwiftUI
import SwiftSafeUI

///
/// Caching image mechanisms:.
/// - Below iOS 16, a dictionary-based cache mechanism is used.
/// - On iOS 16+, an NSCache is utilized for better memory management.
///
final class ImageCache {
    // MARK: - Variables
    private static var cacheDictionary: [URL: Image] = [:]
    private static let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    // MARK: - Configuration
    @MainActor
    static subscript(url: URL) -> Image? {
        get { get(url) }
        set { set(newValue, for: url) }
    }
    
    // MARK: - Private Helpers
    private static func get(_ url: URL) -> Image? {
        if #available(iOS 16, *) {
            if let uiImage = getCachedImage(forKey: url.absoluteString) {
                return Image(uiImage: uiImage)
            } else {
                return nil
            }
        } else {
            return ImageCache.cacheDictionary[url]
        }
    }
    
    @MainActor
    private static func set(_ image: Image?, for url: URL) {
        if #available(iOS 16, *) {
            cacheImage(image?.asUIImage(), forKey: url.absoluteString)
        } else {
            ImageCache.cacheDictionary[url] = image
        }
    }
    
    private static func cacheImage(_ uiImage: UIImage?, forKey key: String) {
        guard let uiImage else { return }
        cache.setObject(uiImage, forKey: key as NSString)
    }
    
    private static func getCachedImage(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
}
