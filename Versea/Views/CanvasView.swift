//
//  CanvasViewController.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.
//
//



import SwiftUI
import Foundation

// 使用 geometryReader 来确定 view 大小并创建一个 grid，每个 grid 都是一个 blockview 显示一个单词和背景


struct CanvasView: View {
    
    @StateObject private var viewModel = CanvasViewModel()
    @State private var colors: [[Color]] = []  // 添加 colors 数组来管理每个 BlockView 的颜色
    
    var body: some View {
        GeometryReader { geometry in
            let blockWidth = (geometry.size.width + 15) / 4  // Block width for 4 columns
            let blockHeight = geometry.size.height / 8 // Block height for 8 rows
            
            ZStack {
                Color("FFFEE3")  // Set background color to FFFEE3
                    .edgesIgnoringSafeArea(.all)
                
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 0) {
                    ForEach(0..<viewModel.grid.count, id: \.self) { row in
                        ForEach(0..<viewModel.grid[row].count, id: \.self) { col in
                            
                            let uniqueID = row * viewModel.grid[row].count + col  // 基于 row 和 col 生成唯一 ID
                            
                            let color = colors[safe: row]?[safe: col] ?? .randomCustomColor()
                            
                            BlockView(word: $viewModel.grid[row][col], backgroundColor: color).id(uniqueID) // 使用自定义的唯一 ID
                                .frame(width: blockWidth, height: blockHeight)
                        }
                    }
                    
                }
            }.onAppear {    initializeColors()  }
        }
        .onShake {
            initializeColors()
            viewModel.regenerateGrid()
        }
    }
    
    private func initializeColors() {
        colors = Array(repeating: Array(repeating: Color.randomCustomColor(), count: 4), count: 8)
        print("colors initialized")
    }
    
//    private func initializeColors() {
//            let numRows = viewModel.grid.count
//            let numCols = viewModel.grid.first?.count ?? 0
//
//            // 初始化二维 colors 数组，并为每个位置分配不同的随机颜色
//            colors = Array(repeating: Array(repeating: Color.clear, count: numCols), count: numRows)
//            
//            for row in 0..<numRows {
//                for col in 0..<numCols {
//                    colors[row][col] = Color.randomCustomColor()
//                }
//            }
//        }
//
}

// 安全访问二维数组元素的扩展
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}




#Preview {
    CanvasView()
}


