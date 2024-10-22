//
//  ViewKitConfig.swift
//  ViewKit
//
//  Created by Baher Tamer on 12/09/2024.
//

import SwiftUI

public final class ViewKitConfig {
    // MARK: - Singleton
    /// A static instance of ViewKitConfig that provides a centralized way to configure package-specific settings.
    public static let shared = ViewKitConfig()
    private init() {}
    
    // MARK: - App Configs
    /// This property defines the primary tint color for the application.\
    /// It can be customized to fit the brand’s color scheme, affecting the appearance of UI elements that rely on the accent color, such as date picker.
    public var appTintColor = Color.accentColor
    
    // MARK: - AsyncImageView Configs
    /// This property holds the default placeholder image used in ``CachedAsyncImage`` when the actual image is failed to load.\
    /// Developers can replace this image with a custom placeholder to match the application’s design.
    public var placeholderImage = Image(.viewkitPlaceholder)
    
    // MARK: - Input Field Configs
    /// This property defines the delay (in seconds) before validating the input field after the user has stopped typing. he default value is set to 1 second.
    public var inputFieldOnEndValidationDelay: Int = 1
}
