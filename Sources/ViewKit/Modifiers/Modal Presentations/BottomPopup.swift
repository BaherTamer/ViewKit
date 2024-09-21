//
//  BottomPopup.swift
//  ViewKit
//
//  Created by Baher Tamer on 11/09/2024.
//

import SwiftUI

extension View {
    ///
    /// Displays a bottom popup view that can be presented and dismissed based on a binding state.
    ///
    /// This function enables you to present a customizable bottom popup that appears over the existing content.
    ///
    /// It accepts a `Binding` to control it's visibility and a closure that provides the content of the popup.
    ///
    /// The popup can be dismissed by dragging it downwards.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ContentView: View {
    ///     @State private var isPopupPresented = false
    ///
    ///     var body: some View {
    ///         Button("Show Popup") {
    ///             isPopupPresented = true
    ///         }
    ///         .bottomPopup(isPresented: $isPopupPresented) {
    ///             GiftCardView()
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - isPresented: A `Binding` to `Bool` that determines whether the bottom popup is currently presented.
    ///   - popupContent: A closure that returns a `@ViewBuilder SwiftUI` view representing the content of the popup.
    ///
    /// - Returns: A `some View` that represents the modified view with the bottom popup functionality applied.
    ///
    public func bottomPopup<PopupContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder popupContent: () -> PopupContent
    ) -> some View {
        modifier(
            BottomPopup(
                isPresented: isPresented,
                popupContent: popupContent()
            )
        )
    }
}

fileprivate struct BottomPopup<PopupContent: View>: ViewModifier {
    // MARK: - Inputs
    @Binding var isPresented: Bool
    let popupContent: PopupContent
    
    // MARK: - Variables
    @GestureState private var dragOffset = CGSize.zero
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                ZStack {
                    popupContent
                }
                .onAppear(perform: setScreenCoverToClear)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
                .shadow(
                    color: .black.opacity(0.4),
                    radius: 36,
                    x: 0,
                    y: 0
                )
                .background { gestureBackground }
            }
    }
    
    // MARK: - Private Helpers
    private func setScreenCoverToClear() {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let controller = windowScene.windows.first?.rootViewController?.presentedViewController
        else { return }
        controller.view.backgroundColor = .clear
    }
}

// MARK: - Drag Gesture
extension BottomPopup {
    private var gestureBackground: some View {
        Color.black
            .opacity(0.0001)
            .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { value, _, _ in
                onGestureUpdate(value)
            }
    }
    
    private func onGestureUpdate(_ value: DragGesture.Value) {
        if value.translation.height > 200 {
            dismiss()
        }
    }
    
    private func dismiss() {
        isPresented = false
    }
}
