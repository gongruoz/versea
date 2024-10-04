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
    @State private var scrollOffset: CGPoint = .zero  // 用于跟踪滚动位置

    let gridSize = CGSize(width: 4, height: 8)  // 定义基本网格的大小
    // 环形滚动时用于复制的次数（为了达到环形效果，创建 5 倍大小的网格）
    let multiplier = 5
    
    var body: some View {
        GeometryReader { geometry in
            let blockWidth = (geometry.size.width+10) / CGFloat(gridSize.width)
            let blockHeight = geometry.size.height / CGFloat(gridSize.height)
            
            ScrollView([.horizontal, .vertical]) {
                
                ZStack {
                    Color("FFFEE3")  // Set background color to FFFEE3
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4),
                              spacing: 0) {
                        ForEach(0..<viewModel.grid.count, id: \.self) { row in
                            ForEach(0..<viewModel.grid[row].count, id: \.self) { col in
                                
                                let uniqueID = row * viewModel.grid[row].count + col  // 基于 row 和 col 生成唯一 ID
                                
                                let color = colors[safe: row]?[safe: col] ?? .randomCustomColor()
                                
                                BlockView(word: $viewModel.grid[row][col], backgroundColor: color).id(uniqueID) // 使用自定义的唯一 ID
                                    .frame(width: blockWidth, height: blockHeight)
                            }
                        }
                        
                    }
                }.onAppear {    initializeColors()  } // zstack
            } // scroll view
        } // geometry reader view
        .onShake {
            initializeColors()
            viewModel.regenerateGrid()
        }
    } // body view
    
    private func initializeColors() {
        colors = Array(repeating: Array(repeating: Color.randomCustomColor(), count: 4), count: 8)
        
    }
} // canvas view

// 安全访问二维数组元素的扩展
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}







#Preview {
    CanvasView()
}


