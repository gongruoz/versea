//
//  CanvasViewControllerWrapper.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/16.
//

import SwiftUI
import UIKit

struct CanvasViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CanvasViewController {
        return CanvasViewController()
    }

    func updateUIViewController(_ uiViewController: CanvasViewController, context: Context) {
        // Optionally update the view controller if needed
    }
}
