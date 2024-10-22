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
    private let isHighlightedBold: Bool
    
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
    ///   - isHighlightedBold: A boolean indicating whether the highlighted text should be bold.
    ///
    /// ## Examples:
    /// ``` swift
    /// HighlightedText(
    ///     "Hello, ^world^! Welcome to ^ViewKit^.",
    ///     color: .blue.opacity(0.3),
    ///     highlightedColor: .blue,
    ///     isHighlightedBold: true
    /// ) // "world" & "ViewKit" will be highlighted & bold.
    /// ```
    ///
    /// > Tip: Don't forget to use the caret (^) to denote which segments should be highlighted.
    ///
    public init(
        _ text: String.LocalizationValue,
        color: Color,
        highlightedColor: Color,
        isHighlightedBold: Bool = false
    ) {
        self.text = text
        self.color = color
        self.highlightedColor = highlightedColor
        self.isHighlightedBold = isHighlightedBold
    }
    
    // MARK: - Body
    public var body: some View {
        Text(attributedString)
    }
}

// MARK: - Private Helpers
fileprivate extension HighlightedText {
    private var attributedString: AttributedString {
        var attributedString = try! AttributedString(markdown: "")
        var segments: [String.SubSequence]
        
        if isHighlightedBold {
            let markdownText = String(localized: text).replacingOccurrences(of: "^", with: "**")
            segments = splitBoldString(markdownText)
        } else {
            segments = String(localized: text).split(separator: "^", omittingEmptySubsequences: false)
        }
        
        for (index, segment) in segments.enumerated() {
            var segmentString = try! AttributedString(markdown: String(segment))
            let currentColor = (index % 2 != 0) ? highlightedColor.asUIColor : color.asUIColor
            segmentString.foregroundColor = currentColor
            attributedString += segmentString
        }
        
        return attributedString
    }
    
    private func splitBoldString(_ input: String) -> [String.SubSequence] {
        let pattern = "(\\*\\*[^\\*]+\\*\\*|[^*]+)"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(
            in: input,
            options: [],
            range: NSRange(location: 0, length: input.utf16.count)
        )
        
        var segments: [String.SubSequence] = []
        for match in matches {
            if let range = Range(match.range, in: input) {
                let segment = input[range]
                segments.append(segment)
            }
        }
        
        return segments
    }
}
