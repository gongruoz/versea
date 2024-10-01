//
//  GridModel.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/29.
//

import Foundation

// The Model represents the data and business logic of your application. It's independent of the user interface. By separating the grid and sentence generation logic into a model, we make it reusable and easier to test.

struct GridModel {
    var grid: [[String]]
    var sentence: String
    
    init(sentence: String) {
        self.sentence = sentence
        self.grid = Self.generate8x4Grid(from: sentence)
    }
    
    static func generate8x4Grid(from sentence: String) -> [[String]] {
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
    
    
    mutating func regenerate() {
        self.sentence = Self.initialSentence()
        self.grid = Self.generate8x4Grid(from: sentence)
    }
    
    static func initialSentence() -> String {
        let questions = [
            //        "WHAT REMAINS WHEN ALL I CLING TO DISAPPEARS",
            //        "WHO AM I BENEATH THE STORIES I TELL MYSELF",
            //        "HOW DOES SILENCE SHAPE THE MEANING OF MY WORDS",
            //        "WHAT WOULD I SEEK IF FEAR NO LONGER HELD SWAY",
            //        "WHERE DOES MY PATH LEAD WHEN I STOP SEARCHING",
            //        "HOW DO I DEFINE FREEDOM WHEN NOTHING BINDS ME",
            //        "WHAT TRUTH DO I AVOID IN THE COMFORT OF HABIT",
            //        "DOES TIME CHANGE WHEN I CEASE TO MEASURE IT",
            //        "DO YOU HEAR THE SOUND OF TIME"
            
//            "OVERHEARD THE ALBATROSS",
//            "HANGS MOTIONLESS UPON THE AIR",
//            "AND DEEP BENEATH THE ROLLING WAVES",
//            "IN LABYRINTHS OF CORAL CAVES",
//            "THE ECHO OF A DISTANT TIME",
//            "COMES WILLOWING ACROSS THE SAND",
//            "AND EVERYTHING IS GREEN AND SUBMARINE",
//            "AND NO ONE SHOWED US TO THE LAND",
//            "AND NO ONE KNOWS THE WHERES OR WHYS",
//            "BUT SOMETHING STIRS AND SOMETHING TRIES",
//            "AND STARTS TO CLIMB TOWARDS THE LIGHT"
            
            "WE ARE THE TIME WE ARE THE FAMOUS",
            "METAPHOR FROM HERACLITUS THE OBSCURE",
            "WE ARE THE WATER NOT THE HARD DIAMOND",
            "THE ONE THAT IS LOST NOT THE ONE THAT STANDS STILL",
            "WE ARE THE RIVER AND WE ARE THAT GREEK",
            "THAT LOOKS HIMSELF INTO THE RIVER",
            "HIS REFLECTION CHANGES INTO THE WATERS OF THE CHANGING MIRROR",
            "INTO THE CRYSTAL THAT CHANGES LIKE THE FIRE",
            "WE ARE THE VAIN PREDETERMINED WATER",
            "IN HIS TRAVEL TO HIS SEA",
            "THE SHADOWS HAVE SURROUNDED HIM",
            "EVERYTHING SAID GOODBYE TO US EVERYTHING GOES AWAY",
            "MEMORY DOES NOT STAMP HIS OWN COIN",
            "HOWEVER THERE IS SOMETHING THAT STAYS",
            "HOWEVER THERE IS SOMETHING THAT BEMOANS"
        ]
        
        return questions.randomElement() ?? ""
    }
    
}
