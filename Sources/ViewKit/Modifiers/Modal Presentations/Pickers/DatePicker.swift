//
//  DatePicker.swift
//  ViewKit
//
//  Created by Baher Tamer on 14/09/2024.
//

import SwiftUI

extension View {
    /// Presents a date picker in a bottom popup, allowing users to select a date.
    ///
    /// This function enables the display of a customizable date picker within a bottom popup. It allows for selection of a date and optionally disables future dates and shows a button to select today’s date.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the date picker.
    ///   - date: A binding for the selected date.
    ///   - disableFutureDates: A `Bool` indicating whether future dates should be disabled in the picker. Default is `false`.
    ///   - showsTodayButton: A `Bool` indicating whether to show a button that sets the date to today. Default is `true`.
    ///
    /// - Returns: A `some` `View` that represents the modified view with the date picker functionality applied.
    ///
    /// ## Example:
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var isDatePickerPresented = false
    ///     @State private var selectedDate = Date()
    ///
    ///     var body: some View {
    ///         VStack {
    ///             Button("Show Date Picker") {
    ///                 isDatePickerPresented = true
    ///             }
    ///
    ///             Text("Selected Date: \(selectedDate)")
    ///                 .padding()
    ///         }
    ///         .datePicker(
    ///             isPresented: $isDatePickerPresented,
    ///             date: $selectedDate,
    ///             disableFutureDates: true,
    ///             showsTodayButton: false
    ///         )
    ///     }
    /// }
    /// ```
    ///
    public func datePicker(
        isPresented: Binding<Bool>,
        date: Binding<Date>,
        disableFutureDates: Bool = false,
        showsTodayButton: Bool = true
    ) -> some View {
        modifier(
            AppDatePicker(
                isPresented: isPresented,
                date: date,
                isFutureDateDisabled: disableFutureDates,
                showsTodayButton: showsTodayButton
            )
        )
    }
}

fileprivate struct AppDatePicker: ViewModifier {
    // MARK: - Inputs
    @Binding var isPresented: Bool
    @Binding var date: Date
    let isFutureDateDisabled: Bool
    let showsTodayButton: Bool
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .bottomPopup(isPresented: $isPresented) {
                pickerView
                    .datePickerStyle(.graphical)
                    .id(date)
                    .pickerBackground()
            }
    }
}

// MARK: - Date Picker Components
fileprivate extension AppDatePicker {
    private var pickerView: some View {
        VStack(alignment: .trailing) {
            todayButton
            datePickerView
        }
    }
    
    @ViewBuilder
    private var todayButton: some View {
        if showsTodayButton {
            Button("Today") {
                date = .now
            }
            .font(.body.weight(.semibold))
            .padding(.top)
        }
    }
    
    @ViewBuilder
    private var datePickerView: some View {
        if isFutureDateDisabled {
            closedRangeDatePicker
        } else {
            datePicker
        }
    }
    
    private var closedRangeDatePicker: some View {
        DatePicker(
            selection: $date,
            in: ...Date(),
            displayedComponents: .date,
            label: {}
        )
    }
    
    private var datePicker: some View {
        DatePicker(
            selection: $date,
            displayedComponents: .date,
            label: {}
        )
    }
}
