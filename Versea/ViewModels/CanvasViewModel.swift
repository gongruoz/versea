//
//  CanvasViewModel.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/29.
//

import Foundation

class CanvasViewModel: ObservableObject {
    @Published private var model: GridModel
    @Published var grid: [[String]] = [] // 可变，等 CanvasView 用 binding 传递值
    
    var sentence: String { model.sentence }
    
    init() {
        self.model = GridModel(sentence: GridModel.initialSentence())
        self.grid = model.grid
    }
    
    func regenerateGrid() {
        model.regenerate()
        self.grid = model.grid // 更新 viewModel 中的 grid，触发视图刷新
    }
    
    func updateWord(at row: Int, col: Int, with newWord: String) {
            guard row < grid.count && col < grid[row].count else { return }
            model.grid[row][col] = newWord  // 更新 model 中的 grid
            self.grid = model.grid  // 更新 viewModel 中的 grid
    }
    
}
