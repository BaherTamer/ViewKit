//
//  ViewKitLogger.swift
//  ViewKit
//
//  Created by Baher Tamer on 27/09/2024.
//

import OSLog

extension Logger {
    private static let subsystem = "com.GitHub.BaherTamer.ViewKit"
}

// MARK: - Loggers
extension Logger {
    static let photosPicker = Logger(subsystem: subsystem, category: "PhotosPicker")
}
