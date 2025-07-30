//
//  Picker.swift
//  ViewKit
//
//  Created by Baher Tamer on 14/09/2024.
//

import SwiftUI
import SwiftSafeUI

extension View {
    ///
    /// Presents a picker view in a bottom popup, allowing users to select an item from a collection.
    ///
    /// This function displays a custom picker within a bottom popup when the specified binding is `true`.
    ///
    /// The picker allows users to select an item from a given collection of data, and the selected item is bound to the provided `selection` binding.
    ///
    /// Each item in the collection is uniquely identified by the `id` key path and displayed using the `title` key path.
    ///
    /// > Important: Ensure that the items in the collection conform to Hashable, as this is required for proper identification and selection. If no item is selected when the picker appears, the first item in the collection will be automatically selected.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a `Boolean` value that determines whether to present the picker.
    ///   - data: A  collection containing `Hashable` elements to display in the picker.
    ///   - selection: A binding to the selected element in the picker.
    ///   - id: A key path to uniquely identify each element in the collection.
    ///   - title: A key path to the title (or displayed string) for each element.
    ///
    /// - Returns: A `some` `View` that represents the modified view with the picker functionality applied.
    ///
    /// ## Example:
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var isPickerPresented = false
    ///     @State private var selectedItem: MyData?
    ///
    ///     let items = [
    ///         MyData(id: 1, name: "Option 1", description: "Description 1"),
    ///         MyData(id: 2, name: "Option 2", description: "Description 2"),
    ///         MyData(id: 3, name: "Option 3", description: "Description 3")
    ///     ]
    ///
    ///     var body: some View {
    ///         VStack {
    ///             Button("Show Picker") {
    ///                 isPickerPresented = true
    ///             }
    ///
    ///             if let selectedItem = selectedItem {
    ///                 Text("Selected: \(selectedItem.name)")
    ///             }
    ///         }
    ///         .picker(
    ///             isPresented: $isPickerPresented,
    ///             data: items,
    ///             selection: $selectedItem,
    ///             id: \.id,
    ///             title: \.name
    ///         )
    ///     }
    /// }
    /// ```
    ///
    public func picker<Collection: RandomAccessCollection, Id: Hashable, Title: Hashable>(
        isPresented: Binding<Bool>,
        data: Collection,
        selection: Binding<Collection.Element?>,
        id: KeyPath<Collection.Element, Id>,
        title: KeyPath<Collection.Element, Title>
    ) -> some View where Collection.Element: Hashable {
        modifier(
            AppPicker(
                isPresented: isPresented,
                selection: selection,
                data: data,
                id: id,
                title: title
            )
        )
    }
}

fileprivate struct AppPicker<
    Collection: RandomAccessCollection,
    Id: Hashable,
    Title: Hashable
>: ViewModifier where Collection.Element: Hashable {
    // MARK: - Inputs
    @Binding var isPresented: Bool
    @Binding var selection: Collection.Element?
    let data: Collection
    let id: KeyPath<Collection.Element, Id>
    let title: KeyPath<Collection.Element, Title>
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .bottomPopup(isPresented: $isPresented) {
                pickerView
                    .pickerStyle(.wheel)
                    .pickerBackground()
                    .onAppear(perform: selectFirstItem)
            }
    }
    
    // MARK: - Private Helpers
    private func selectFirstItem() {
        if selection == nil {
            selection = data.first
        }
    }
}

// MARK: - Picker Components
fileprivate extension AppPicker {
    private var pickerView: some View {
        Picker(selection: $selection) {
            ForEach(data, id: id, content: pickerItem)
        } label: {}
    }
    
    private func pickerItem(_ item: Collection.Element) -> some View {
        Text(verbatim: "\(item[keyPath: title])")
            .tag(item as Collection.Element?)
    }
}
