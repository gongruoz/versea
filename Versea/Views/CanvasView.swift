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
                        Color(red: 1.0, green: 1.0, blue: 0.89)
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
            }
        }
    }
}
