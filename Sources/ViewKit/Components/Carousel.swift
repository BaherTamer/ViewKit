//
//  Carousel.swift
//  ViewKit
//
//  Created by Baher Tamer on 19/09/2024.
//

import SwiftUI

public struct Carousel<Data, Id, Content, Indicator>: View
where Data: RandomAccessCollection,
      Data.Element: Hashable,
      Data.Index: Hashable,
      Id: Hashable,
      Content: View,
      Indicator: View
{
    // MARK: - Inputs
    private let data: Data
    private let id: KeyPath<Data.Element, Id>
    private let showsIndicators: Bool
    @ViewBuilder private let content: (Data.Element) -> Content
    @ViewBuilder private let indicator: ((Data.Element, Bool) -> Indicator)?
    
    // MARK: - Variables
    @State private var currentIndex = 0
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    // MARK: - Environment Values
    @Environment(\.carouselTimeInterval) private var timeInterval
    @Environment(\.carouselHorizontalPadding) private var horizontalPadding
    @Environment(\.carouselVerticalSpacing) private var carouselVSpacing
    @Environment(\.carouselHorizontalSpacing) private var carouselHSpacing
    @Environment(\.carouselIndicatorHorizontalSpacing) private var indicatorHSpacing
    @Environment(\.carouselIndicatorSize) private var indicatorSize
    @Environment(\.carouselIndicatorActiveColor) private var indicatorActiveColor
    @Environment(\.carouselIndicatorInactiveColor) private var indicatorInactiveColor
    
    // MARK: - Life Cycle
    ///
    /// Creates a `Carousel` with the specified data, identifier key path, and content view for each element.
    ///
    /// A `SwiftUI` view that presents a horizontally auto scrollable collection of items with optional indicators to show the current selection.
    ///
    /// - Parameters:
    ///   - data: A collection of elements to be displayed in the carousel.
    ///   - id: A key path for identifying elements in the data.
    ///   - showsIndicators: A Boolean indicating if indicators should be shown. Default is `true`.
    ///   - content: A closure that produces a view for each element in the data.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ContentView: View {
    ///     let items = ["Item 1", "Item 2", "Item 3"]
    ///
    ///     var body: some View {
    ///         Carousel(items, id: \.self) { item in
    ///             Text(item)
    ///                 .frame(maxWidth: .infinity, maxHeight: 200)
    ///                 .background(.blue)
    ///                 .roundedCorners(10)
    ///         }
    ///     }
    /// }
    /// ```
    ///
    public init(
        _ data: Data,
        id: KeyPath<Data.Element, Id>,
        showsIndicators: Bool = true,
        // FIXME: Avoid using `@escaping`
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) where Indicator == EmptyView {
        self.data = data
        self.id = id
        self.showsIndicators = showsIndicators
        self.content = content
        self.indicator = nil
    }
    
    ///
    /// Creates a `Carousel` with the specified data, identifier key path, content view, and a custom indicator view for each element.
    ///
    /// A `SwiftUI` view that presents a horizontally auto scrollable collection of items with optional indicators to show the current selection.
    ///
    /// - Parameters:
    ///   - data: A collection of elements to be displayed in the carousel.
    ///   - id: A key path for identifying elements in the data.
    ///   - content: A closure that produces a view for each element in the data.
    ///   - indicator: A closure that produces a custom indicator view for each element, taking the data element and a `Bool` indicating if it’s the current index.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ContentView: View {
    ///     let items = ["Item 1", "Item 2", "Item 3"]
    ///
    ///     var body: some View {
    ///         Carousel(items, id: \.self) { item in
    ///             Text(item)
    ///                 .frame(maxWidth: .infinity, maxHeight: 200)
    ///                 .background(.blue)
    ///                 .roundedCorners(10)
    ///         } indicator: { item, isActive in
    ///             Capsule()
    ///                 .fill(.blue.opacity(isSelected ? 1 : 0.3))
    ///                 .frame(width: isSelected ? 24 : 8, height: 8)
    ///         }
    ///     }
    /// }
    /// ```
    ///
    public init(
        _ data: Data,
        id: KeyPath<Data.Element, Id>,
        // FIXME: Avoid using `@escaping`
        @ViewBuilder content: @escaping (Data.Element) -> Content,
        @ViewBuilder indicator: @escaping (Data.Element, Bool) -> Indicator
    ) {
        self.data = data
        self.id = id
        self.showsIndicators = true
        self.content = content
        self.indicator = indicator
    }
    
    // MARK: - Body
    public var body: some View {
        VStack(spacing: carouselVSpacing) {
            scrollView
            indicatorsView
        }
        .onAppear(perform: setDefaultTimer)
    }
    
    // MARK: - Private Helpers
    private func setDefaultTimer() {
        timer = Timer.publish(
            every: timeInterval,
            on: .main,
            in: .common
        ).autoconnect()
    }
}

// MARK: - Components
extension Carousel {
    private var scrollView: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                contentView
            }
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % data.count
                    proxy.scrollTo(currentIndex, anchor: .center)
                }
            }
        }
    }
    
    private var contentView: some View {
        LazyHStack(spacing: carouselHSpacing) {
            ForEach(data.indices, id: \.self) { index in
                content(data[index])
                    .id(index)
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
}

// MARK: - Indicator Components
extension Carousel {
    private var indicatorsView: some View {
        HStack(spacing: indicatorHSpacing) {
            ForEach(
                0 ..< data.count,
                id: \.self,
                content: indicatorItem
            )
        }
        .padding(.horizontal, horizontalPadding)
    }
    
    @ViewBuilder
    private func indicatorItem(_ index: Range<Array<Any>.Index>.Element) -> some View {
        if let _ = indicator {
            customIndicatorItem(index)
        } else if showsIndicators {
            defaultIndicatorItem(index)
        }
    }
    
    private func defaultIndicatorItem(_ index: Range<Array<Any>.Index>.Element) -> some View {
        Circle()
            .fill(currentIndex == index ? indicatorActiveColor : indicatorInactiveColor)
            .frame(
                width: indicatorSize,
                height: indicatorSize
            )
    }
    
    private func customIndicatorItem(_ index: Range<Array<Any>.Index>.Element) -> some View {
        indicator?(
            data[index as! Data.Index],
            currentIndex == index
        )
    }
}

// MARK: - Styles Configurations
extension View {
    /// Sets the time interval for automatic scrolling of the carousel. Default value is `5`
    public func carouselTimeInterval(_ interval: TimeInterval) -> some View {
        environment(\.carouselTimeInterval, interval)
    }
    
    /// Sets the horizontal padding for the carousel content. Default value is `16`
    public func carouselHorizontalPadding(_ padding: CGFloat) -> some View {
        environment(\.carouselHorizontalPadding, padding)
    }
    
    /// Sets the vertical spacing between the carousel content and indicators. Default value is `16`
    public func carouselVerticalSpacing(_ spacing: CGFloat) -> some View {
        environment(\.carouselVerticalSpacing, spacing)
    }
    
    /// Sets the horizontal spacing between items in the carousel. Default value is `8`
    public func carouselHorizontalSpacing(_ spacing: CGFloat) -> some View {
        environment(\.carouselHorizontalSpacing, spacing)
    }
    
    /// Sets the horizontal spacing between indicators. Default value is `8`
    public func carouselIndicatorHorizontalSpacing(_ spacing: CGFloat) -> some View {
        environment(\.carouselIndicatorHorizontalSpacing, spacing)
    }
    
    /// Sets the size of the indicators. Default value is `8`
    public func carouselIndicatorSize(_ size: CGFloat) -> some View {
        environment(\.carouselIndicatorSize, size)
    }
    
    /// Sets the color for the active indicator.
    public func carouselIndicatorActiveColor(_ color: Color) -> some View {
        environment(\.carouselIndicatorActiveColor, color)
    }
    
    /// Sets the color for the inactive indicators.
    public func carouselIndicatorInactiveColor(_ color: Color) -> some View {
        environment(\.carouselIndicatorInactiveColor, color)
    }
}

// MARK: - Environment Values
fileprivate extension EnvironmentValues {
    // Timer
    @Entry var carouselTimeInterval: TimeInterval = 5
    
    // Spaces
    @Entry var carouselHorizontalPadding: CGFloat = 16
    @Entry var carouselVerticalSpacing: CGFloat = 16
    @Entry var carouselHorizontalSpacing: CGFloat = 8
    @Entry var carouselIndicatorHorizontalSpacing: CGFloat = 8
    
    // Sizes
    @Entry var carouselIndicatorSize: CGFloat = 8
    
    // Colors
    @Entry var carouselIndicatorActiveColor: Color = ViewKitConfig.shared.appTintColor
    @Entry var carouselIndicatorInactiveColor: Color = ViewKitConfig.shared.appTintColor.opacity(0.3)
}
