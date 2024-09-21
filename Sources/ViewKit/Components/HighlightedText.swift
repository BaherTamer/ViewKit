//
//  HighlightedText.swift
//  ViewKit
//
//  Created by Baher Tamer on 21/09/2024.
//

import SwiftUI

public struct HighlightedText: View {
    // MARK: - Inputs
    private let text: String.LocalizationValue
    private let color: Color
    private let highlightedColor: Color
    
    ///
    /// A view that displays text with alternating colors, allowing specific segments of the text to be highlighted.
    ///
    /// The ``HighlightedText`` struct is designed to facilitate the display of text with custom highlighting. It takes a localized string value and applies different colors to alternating segments of the text based on a specified delimiter.
    ///
    /// - Parameters:
    ///   - text: A localized string representing the text to be displayed. Segments of the text that should be
    ///     highlighted must be wrapped in caret (`^`) within the localized string.
    ///   - color: The color to use for the regular text.
    ///   - highlightedColor: The color to use for the highlighted text segments.
    ///
    /// ## Examples:
    /// ``` swift
    /// HighlightedText(
    ///     "Hello, ^world^! Welcome to ^ViewKit^.",
    ///     color: .blue.opacity(0.3),
    ///     highlightedColor: .blue
    /// ) // "world" & "ViewKit" will be highlighted.
    /// ```
    ///
    /// > Tip: Don't forget to use the caret (^) to denote which segments should be highlighted.
    ///
    public init(
        _ text: String.LocalizationValue,
        color: Color,
        highlightedColor: Color
    ) {
        self.text = text
        self.color = color
        self.highlightedColor = highlightedColor
    }
    
    // MARK: - Body
    public var body: some View {
        Text(attributedString)
    }
    
    // MARK: - Private Helpers
    private var attributedString: AttributedString {
        var attributedString = AttributedString()
        let segments = String(localized: text).split(separator: "^", omittingEmptySubsequences: false)
        
        for (index, segment) in segments.enumerated() {
            var segmentString = AttributedString(String(segment))
            let currentColor = (index % 2 != 0) ? highlightedColor.asUIColor : color.asUIColor
            segmentString.foregroundColor = currentColor
            attributedString += segmentString
        }
        
        return attributedString
    }
}
