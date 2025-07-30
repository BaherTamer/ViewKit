//
//  ShareView.swift
//  ViewKit
//
//  Created by Baher Tamer on 24/09/2024.
//

import SwiftUI
import SwiftSafeUI

struct ShareView: UIViewControllerRepresentable {
    // MARK: - Inputs
    let items: [Any]
    
    // MARK: - Config Functions
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityController = UIActivityViewController(
            activityItems:items,
            applicationActivities: nil
        )
        
        return activityController
    }
    
    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: Context
    ) {}
}
