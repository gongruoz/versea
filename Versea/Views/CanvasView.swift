//
//  CanvasViewController.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.
//
//



import SwiftUI
import Foundation

// ------


struct CanvasView: View {
    @StateObject private var viewModel = CanvasViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let blockWidth = (geometry.size.width + 15) / 4  // Block width for 4 columns
            let blockHeight = geometry.size.height / 8 // Block height for 8 rows
            
            ZStack {
                Color("FFFDD3")  // Set background color to FFFDD3
                    .edgesIgnoringSafeArea(.all)
                
                // Grid content
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 0) {
                    ForEach(0..<8, id: \.self) { row in
                        ForEach(0..<4, id: \.self) { col in
                            if row < viewModel.grid.count && col < viewModel.grid[row].count {
                                BlockView(word: viewModel.grid[row][col], backgroundColor: Color.randomCustomColor())
                                    .frame(width: blockWidth, height: blockHeight)  // Ensuring consistent block sizes
                            }
                        }
                    }
                }
            }
            .onAppear {
                // The grid is already generated in the ViewModel's init, so we don't need to do anything here
            }
            .onShake {
                // Update the grid when the device is shaken
                viewModel.regenerateGrid()
            }
        }
    }
}



#Preview {
    CanvasView()
}


