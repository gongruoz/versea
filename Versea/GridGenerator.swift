//
//  GridGenerator.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/19.
//

import Foundation

// Function that takes a sentence, splits it into words, and returns an 8x4 grid
func generate8x4Grid(from sentence: String) -> [[String]] {
    // Split sentence into individual words
    let words = sentence.components(separatedBy: " ")
    
    // Initialize an 8x4 grid with empty strings
    let numCol: Int = 4
    let numRow: Int = 8
    var grid = Array(repeating: Array(repeating: "", count: numCol), count: numRow)
    
    let totalCells = numCol*numRow  // 8x4 grid has 32 cells
    let wordCount = words.count
    
    // Ensure we have enough words to fill some of the grid
    guard wordCount <= totalCells else {
        print("Error: Too many words for the grid!")
        return grid
    }
    
    // Generate n random unique positions from 0 to 31
    let randomPositions = Array(0..<totalCells).shuffled().prefix(wordCount).sorted()
    
    // Map random positions to (row, col) in the grid
    var wordIndex = 0
    for position in randomPositions {
        let row = position / 4  // Calculate the row index
        let col = position % 4  // Calculate the column index
        grid[row][col] = words[wordIndex]  // Place the word in the grid
        wordIndex += 1
    }
    
    return grid
}
