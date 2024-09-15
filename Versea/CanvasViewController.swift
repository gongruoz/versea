//
//  CanvasViewController.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.
//

import Foundation
import UIKit

class CanvasViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        generateInitialBlocks()
        
        // Detect shake gesture
        becomeFirstResponder()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.frame.width * 2, height: view.frame.height * 2) // Infinite scrolling
        view.addSubview(scrollView)
    }
    
    func generateInitialBlocks() {
        // Create some initial blocks for demo
        for i in 0..<10 {
            let blockSize: CGFloat = 100
            let blockView = BlockView(frame: CGRect(x: CGFloat(i) * blockSize, y: CGFloat(i) * blockSize, width: blockSize, height: blockSize))
            scrollView.addSubview(blockView)
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Device shaken: Refresh all blocks")
            // Trigger refresh of all blocks on shake
            for subview in scrollView.subviews {
                if let blockView = subview as? BlockView {
                    blockView.updateBlockContent()
                }
            }
        }
    }
}

#Preview {
    CanvasViewController()
}

