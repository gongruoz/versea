//
//  RegionManager.swift
//  Versea
//
//  Created by Hazel Gong on 2024/10/10.
//

import Foundation
import SwiftUI

struct ScreenID: Hashable, CustomStringConvertible {
    let x: Int
    let y: Int

    var description: String {
        return "(\(x), \(y))"
    }
}


class RegionManager: ObservableObject {
    @Published var screenStates: [ScreenID: ScreenState] = [:]  // 用于存储所有屏幕的状态
    var allBlocks: [BlockID: Block] = [:]  // 存储整个画布的所有 blocks

    let gridSize: CGSize
    let multiplier: Int
    
    init(gridSize: CGSize, multiplier: Int) {
        self.gridSize = gridSize
        self.multiplier = multiplier
        initializeCanvas(gridSize: gridSize, multiplier: multiplier)
    }

    // 初始化整个画布
    private func initializeCanvas(gridSize: CGSize, multiplier: Int) {
        let totalBlocksX = Int(gridSize.width) * multiplier
        let totalBlocksY = Int(gridSize.height) * multiplier
        
        // 生成所有 blocks 并存储到 allBlocks
        for x in 0..<totalBlocksX {
            for y in 0..<totalBlocksY {
                let blockID = BlockID(screenIndex: x, blockIndex: y)
                let position = (x: x, y: y)
                let randomColor = Color.randomCustomColor()
                let newBlock = Block(id: blockID, position: position, backgroundColor: randomColor)
                allBlocks[blockID] = newBlock
            }
        }

        // 将 blocks 分配到每个 ScreenState
        for x in 0..<totalBlocksX {
            for y in 0..<totalBlocksY {
                let screenID = ScreenID(x: x / Int(gridSize.width), y: y / Int(gridSize.height))
                if screenStates[screenID] == nil {
                    screenStates[screenID] = ScreenState(screenID: screenID)
                }
                // 将 block 添加到对应 screen 的 blocks 列表
                screenStates[screenID]?.blocks[BlockID(screenIndex: x, blockIndex: y)] = allBlocks[BlockID(screenIndex: x, blockIndex: y)]
            }
        }
    }

    // 获取当前显示的屏幕状态
    func getScreenState(at screenID: ScreenID) -> ScreenState {
        return screenStates[screenID] ?? ScreenState(screenID: screenID)
    }
}
