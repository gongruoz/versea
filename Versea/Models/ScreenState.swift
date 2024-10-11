//
//  ScreenState.swift
//  Versea
//
//  Created by Hazel Gong on 2024/10/10.
//

import Foundation

// Step 2: Implement the ScreenState class
class ScreenState: ObservableObject {
    let screenID: ScreenID                                      // Use the shared ScreenID type

    @Published var blocks: [BlockID: Block] = [:]               // Store all blocks within this screen
    var occupancyRate: Double = 0

    init(screenID: ScreenID) {
        self.screenID = screenID
        initializeBlocks()                                      // Initialize the blocks when the screen is created
        calculateOccupancyRate()                                // Initialize the occupancy rate
    }

    // Step 2.1: Initialize a set of empty blocks for this screen
    private func initializeBlocks() {
        for y in 0..<8 {                                         // 8 rows
            for x in 0..<4 {                                     // 4 columns
                let blockID = BlockID(screenIndex: screenID.x, blockIndex: (x + y * 4))
                let position = (x: x, y: y)
                blocks[blockID] = Block(id: blockID, position: position)  // Create empty blocks
            }
        }
    }

    // Step 2.2: Update the text of a specific block
    func updateBlockText(at blockID: BlockID, with newText: String) {
        if var block = blocks[blockID] {
            block.text = newText
            blocks[blockID] = block                              // Save the updated block back to the dictionary
        }
    }

    // Step 2.3: Capture a specific block
    func captureBlock(at blockID: BlockID) {
        if var block = blocks[blockID], block.isFlashing {       // Ensure the block is flashing before capturing
            block.isCaptured = true
            block.isFlashing = false
            blocks[blockID] = block                              // Save the updated block
            calculateOccupancyRate()                             // Update occupancy rate after capturing
        }
    }

    // Step 2.4: Calculate the percentage of captured blocks
    private func calculateOccupancyRate() {
        let totalBlocks = blocks.count
        let capturedBlocks = blocks.values.filter { $0.isCaptured }.count
        self.occupancyRate = Double(capturedBlocks) / Double(totalBlocks)
    }

    // Step 2.5: Debugging method to print the current state of all blocks
    func printAllBlocks() {
        for (_, block) in blocks {
            print(block)
        }
    }
}
