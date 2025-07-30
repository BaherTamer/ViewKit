//
//  Line.swift
//  ViewKit
//
//  Created by Baher Tamer on 23/10/2024.
//

import SwiftUI
import SwiftSafeUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}
