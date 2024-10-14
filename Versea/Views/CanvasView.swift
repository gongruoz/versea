//
//  CanvasViewController.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.
//
//

import SwiftUI
import Foundation


struct CanvasView: View {
    @ObservedObject private var regionManager: RegionManager
    @State private var contentOffset: CGSize = .zero  // 跟踪内容的总偏移量
    
    let gridSize = CGSize(width: 4, height: 8)  // 定义单个屏幕的 grid
    
    init() {
        self.regionManager = RegionManager(gridSize: gridSize, multiplier: 3)  // 初始化整个大画布
    }

    var body: some View {
        GeometryReader { geometry in
            let blockWidth = (geometry.size.width + 10) / CGFloat(gridSize.width)
            let blockHeight = (geometry.size.height + 10) / CGFloat(gridSize.height)
            let totalWidth = blockWidth * CGFloat(gridSize.width) * CGFloat(regionManager.multiplier)
            let totalHeight = blockHeight * CGFloat(gridSize.height) * CGFloat(regionManager.multiplier)
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack {
                        Color("FFFEE3")
                            .frame(width: totalWidth, height: totalHeight)
                            .edgesIgnoringSafeArea(.all)

                        LazyVGrid(columns: Array(repeating: GridItem(.fixed(blockWidth), spacing: 0), count: Int(totalWidth / blockWidth)), spacing: 0) {
                            ForEach(Array(regionManager.allBlocks.values), id: \.id) { block in
                                BlockView(word: .constant(block.text ?? ""), backgroundColor: block.backgroundColor)
                                    .frame(width: blockWidth, height: blockHeight)
                            }
                        }
                    }
                }
                .onChange(of: contentOffset) { newOffset in
                    handleScrolling(newOffset)
                }
            }
        }
    }

    // 处理滚动，计算当前所在的 screenID
    private func handleScrolling(_ newOffset: CGSize) {
        let blockSize = CGSize(width: 100, height: 100)  // 定义 block 的大小
        let screenID = ScreenID(
            x: Int(newOffset.width / blockSize.width),
            y: Int(newOffset.height / blockSize.height)
        )
        regionManager.getScreenState(at: screenID)  // 更新当前屏幕状态
    }
}
