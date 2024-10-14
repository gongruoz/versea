//
//  Block.swift
//  Versea
//
//  Created by Hazel Gong on 2024/10/10.
//

import SwiftUI
import Foundation

struct BlockID: Hashable {
    let screenIndex: Int
    let blockIndex: Int
}

// Define the Block struct
struct Block: Identifiable, CustomStringConvertible {
    let id: BlockID                                          // Unique identifier for the block

    var position: (x: Int, y: Int)                           // Position within the screen
    var text: String? = nil                                  // Optional text displayed in the block
    var isFlashing: Bool = false                             // Indicates if the block is currently flashing
    var isCaptured: Bool = false                             // Indicates if the block has been captured by the user
    var backgroundColor: Color

    // Custom description for easy testing and display
    var description: String {
        return "Block(id: \(id), position: (\(position.x), \(position.y)), text: \(text ?? "nil"), isFlashing: \(isFlashing), isCaptured: \(isCaptured)), backgroundColor: \(backgroundColor))"
    }
}

