//
//  CanvasViewModel.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/29.
//

import Foundation

class CanvasViewModel: ObservableObject {
    @Published private var model: GridModel
    @Published var grid: [[String]] = []  // 原始网格数据
    var multiplier: Int = 1 // 用来扩展视图的倍数

    // 计算属性，返回扩展后的网格
    var extendedGrid: [[String]] {
        var extended: [[String]] = []
        
        // 将原始 grid 复制 multiplier 倍，并使用模运算映射
        for row in 0..<(grid.count * multiplier) {
            var extendedRow: [String] = []
            for col in 0..<(grid[0].count * multiplier) {
                let originalRow = row % grid.count  // 使用模运算映射行索引
                let originalCol = col % grid[0].count  // 使用模运算映射列索引
                extendedRow.append(grid[originalRow][originalCol])
            }
            extended.append(extendedRow)
        }
        
        return extended
    }

    init(multiplier: Int) {
        self.model = GridModel(sentence: GridModel.initialSentence())
        self.grid = model.grid
        self.multiplier = multiplier  // 初始化 multiplier
    }

    func regenerateGrid() {
        model.regenerate()
        self.grid = model.grid  // 更新 ViewModel 中的 grid
    }

    func updateWord(at row: Int, col: Int, with newWord: String) {
        guard row < grid.count && col < grid[row].count else { return }
        model.updateWord(at: row, col: col, with: newWord)  // 更新 Model 中的网格
        self.grid = model.grid  // 更新 ViewModel 中的网格
    }
}

