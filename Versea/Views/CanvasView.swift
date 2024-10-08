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
    @StateObject private var viewModel = CanvasViewModel(multiplier: 3)
    @State private var colors: [[Color]] = []  // 添加 colors 数组来管理每个 BlockView 的颜色
//    @State private var translation: CGSize = .zero  // 跟踪滑动的偏移量
    @State private var contentOffset: CGSize = .zero  // 跟踪内容的总偏移量
    
    let gridSize = CGSize(width: 4, height: 8)  // 定义基本网格的大小
    // 环形滚动时用于复制的次数（为了达到环形效果，创建 5 倍大小的网格）

    var body: some View {
        GeometryReader { geometry in
            let blockWidth = (geometry.size.width+10) / CGFloat(gridSize.width)
            let blockHeight = (geometry.size.height+10) / CGFloat(gridSize.height)
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack {
                        Color("FFFEE3")  // Set background color to FFFEE3
                            .edgesIgnoringSafeArea(.all)
                        
                        // 使用 extendedGrid 生成更大的 LazyVGrid
                        LazyVGrid(columns: Array(repeating: GridItem(.fixed(blockWidth), spacing: 0), count: viewModel.extendedGrid[0].count), spacing: 0) {
                            ForEach(0..<viewModel.extendedGrid.count, id: \.self) { row in
                                ForEach(0..<viewModel.extendedGrid[row].count, id: \.self) { col in
                                    
                                    let originalRow = row % viewModel.grid.count
                                    let originalCol = col % viewModel.grid[0].count
                                    
                                    let uniqueID = row * viewModel.grid[originalRow].count + col  // 基于 row 和 col 生成唯一 ID
                                    
                                    // 根据原始行列映射回原始 grid 中的数据
                                    let color = Color.randomCustomColor()
                                    
                                    BlockView(word: $viewModel.grid[originalRow][originalCol], backgroundColor: color).id(uniqueID)
                                        .frame(width: blockWidth, height: blockHeight)
                                }
                            }
                        } // lazyvgrid
                        .offset(x: contentOffset.width, y: contentOffset.height)
        
                    }
                }
                .onAppear {    initializeColors()  } // zstack
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


