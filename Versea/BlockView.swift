//
//  BlockView.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.
//

import Foundation
import UIKit

class BlockView: UIView {
    
    var wordLabel: UILabel!
    var color: UIColor = .blue
    var word: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Initial block color and label setup
        backgroundColor = color
        wordLabel = UILabel(frame: bounds)
        wordLabel.textAlignment = .center
        wordLabel.textColor = .white
        wordLabel.numberOfLines = 0
        addSubview(wordLabel)
        
        // Gesture recognizers
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        
        addGestureRecognizer(tapGesture)
        addGestureRecognizer(doubleTapGesture)
        addGestureRecognizer(longPressGesture)
        addGestureRecognizer(panGesture)
    }
    
    @objc private func handleSingleTap() {
        // Call LLM API to update block content
        updateBlockContent()
    }
    
    @objc private func handleDoubleTap() {
        // Center this block and refresh all others
        print("Double tapped: Center this block and refresh others.")
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            print("Long pressed: Allow user to input text.")
            // Show input dialog to change text
        }
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            let translation = gesture.translation(in: self.superview)
            self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
            gesture.setTranslation(.zero, in: self.superview)
        }
    }
    
    func updateBlockContent() {
        // Example: Call the LLM API to fetch a new word and update the block
        // Here we'll just simulate with placeholder text
        let newWord = "NewWord"
        word = newWord
        wordLabel.text = newWord
        
        // Change the background color
        backgroundColor = .randomBlueShade()
    }
}

extension UIColor {
    static func randomBlueShade() -> UIColor {
        let blueShades = [UIColor.blue, UIColor.cyan, UIColor.systemTeal]
        return blueShades.randomElement() ?? .blue
    }
}

