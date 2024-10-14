//
//  CanvasViewController.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.
//
//

import SwiftUI
import Foundation


struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

struct CanvasView: View {
    @ObservedObject private var regionManager: RegionManager
    @State private var contentOffset: CGPoint = .zero  // CGPoint instead of CGSize

    let gridSize = CGSize(width: 4, height: 8)

    init() {
        self.regionManager = RegionManager(gridSize: gridSize, multiplier: 3)
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
                            GeometryReader { proxy in
                                LazyVGrid(columns: Array(repeating: GridItem(.fixed(blockWidth), spacing: 0), count: Int(totalWidth / blockWidth)), spacing: 0) {
                                    ForEach(Array(regionManager.allBlocks.values), id: \.id) { block in
                                        BlockView(word: .constant(block.text ?? ""), backgroundColor: block.backgroundColor)
                                            .frame(width: blockWidth, height: blockHeight)
                                    }
                                }
                            // 使用 GeometryReader 获取偏移
                            .background(GeometryReader { geoProxy in
                                Color.clear
                                    .preference(key: ScrollOffsetPreferenceKey.self, value: geoProxy.frame(in: .named("scroll")).origin)
                            })
                        }
                        
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                print("Captured Scroll Offset: \(value)") // Debug
                contentOffset = value
                handleScrolling(value)
                print("Content offset changed to: \(contentOffset)") // 确认是否成功捕捉
            }
        }
    }

    private func handleScrolling(_ newOffset: CGPoint) {
        // 定义每个 block 的大小
        let blockSize = CGSize(width: 100, height: 100)
        
        // 根据新的 offset 计算当前的 screenID
        let screenID = ScreenID(
            x: Int(newOffset.x / blockSize.width),
            y: Int(newOffset.y / blockSize.height)
        )

        // Debug 信息: 打印新的 offset
        print("Content offset changed: \(newOffset)")
        
        // Debug 信息: 打印当前的 screenID
        print("Current screen ID: \(screenID)")
        
        // 更新当前的 screen 状态
        let screenState = regionManager.getScreenState(at: screenID)
        
        // Debug 信息: 打印当前屏幕的 blocks 和它们的 ID
//        print("Blocks in current screen:")
//        for (blockID, block) in screenState.blocks {
//            print("BlockID: \(blockID), Block Text: \(block.text ?? ""), Position: (\(block.position.x), \(block.position.y))")
//        }
    }
}
