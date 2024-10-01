//
//  BlockView.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.

// add onTap

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct BlockView: View {
    var word: String
    @State var backgroundColor: Color
    
    var body: some View {
        ZStack {
            if let noiseImage = generateNoiseImage() {
                Image(uiImage: noiseImage)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5)
            }
            
            backgroundColor  // 使用背景颜色
                .opacity(0.75)
            
            Text(word)  // 显示单词
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .font(.custom("Pixelify Sans", size: 25))
                .bold()
        }
        .clipped()
        .onTapGesture {
            let newColor = Color.randomCustomColor()  // 新的随机颜色
            self.backgroundColor = newColor  // 更新背景颜色
        }
    }
}

