//
//  WebSheet.swift
//  ViewKit
//
//  Created by Baher Tamer on 21/09/2024.
//

import SwiftUI

extension View {
    ///
    /// Presents a sheet containing a web view that displays the specified URL.
    ///
    /// This function allows you to present a web view in a sheet, enabling users to view web content directly within your app.
    ///
    /// It utilizes a `Binding` to control the presentation state and accepts a URL string to load the desired web page.\
    /// Optionally, you can provide a navigation title for the web view, which appears in the navigation bar.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ContentView: View {
    ///     @State private var isWebSheetPresented = false
    ///     private let urlString = "https://www.example.com"
    ///
    ///     var body: some View {
    ///         Button("Open Web Page") {
    ///             isWebSheetPresented = true
    ///         }
    ///         .webSheet(
    ///             isPresented: $isWebSheetPresented,
    ///             urlString: urlString,
    ///             navigationTitle: "Example Website"
    ///         )
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - isPresented: A `Binding` to `Bool` that determines whether the web sheet is currently presented.
    ///   - urlString: A `String` representing the URL to be loaded in the web view.
    ///   - navigationTitle: An optional `String` for the navigation bar title. If not provided, the navigation bar title will be hidden.
    ///
    /// - Returns: A `some View` that represents the modified view with the web sheet functionality applied.
    ///
    public func webSheet(
        isPresented: Binding<Bool>,
        urlString: String,
        navigationTitle: String? = nil
    ) -> some View {
        modifier(
            WebSheet(
                isPresented: isPresented,
                urlString: urlString,
                navigationTitle: navigationTitle
            )
        )
    }
}

fileprivate struct WebSheet: ViewModifier {
    // MARK: - Inputs
    @Binding var isPresented: Bool
    let urlString: String
    let navigationTitle: String?
    
    // MARK: - Variables
    private var isNavigationBarHidden: Bool {
        navigationTitle == nil
    }
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    webView
                }
            }
    }
    
    // MARK: - Components
    private var webView: some View {
        WebView(urlString: urlString)
            .ignoresSafeArea()
            .navigationTitle(navigationTitle ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .safeNavBarHidden(isNavigationBarHidden)
    }
}
