//
//  WebView.swift
//  ViewKit
//
//  Created by Aser Eid on 21/09/2024.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    private let urlString: String
    
    /// A SwiftUI view that wraps a `WKWebView` for displaying web content.
    ///
    /// The ``WebView`` struct allows developers to present web pages within a `SwiftUI` application. It leverages `UIViewRepresentable` to integrate the `WKWebView`, enabling rich web content display and interaction.
    ///
    /// - Parameters:
    ///   - urlString: A `String` representing the URL of the web page to be loaded.
    ///
    /// ## Example
    ///  ``` swift
    ///  NavigationView {
    ///      WebView(urlString: "https://www.example.com")
    ///  }
    ///  ```
    ///
    public init(urlString: String) {
        self.urlString = urlString
    }

    public func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    public func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
