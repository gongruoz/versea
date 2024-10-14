//
//  BlockView.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.

// add onTap

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

// 单个方块的视图，包括文字显示和背景效果
struct BlockView: View {
    @Binding var word: String  // 用 @Binding 管理外部的 word
    @State var backgroundColor: Color  // 用 @State 管理颜色的状态
    
    init(word: Binding<String>, backgroundColor: Color) {
        self._word = word
        self._backgroundColor = State(initialValue: backgroundColor)
    }
    
    var body: some View {
        ZStack {
            backgroundColor  // 使用背景颜色
                .opacity(0.75)
            
            // 添加噪音颗粒效果
            if let noiseImage = generateNoiseImage() {
                Image(uiImage: noiseImage)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.25)
            }
            
            Text(word)  // 显示单词
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .font(.custom("Pixelify Sans", size: 25))
                .bold()
        }
        .clipped()
//        .onTapGesture {
            // 当点击时，生成新的内容
            //            let newWord = generateRelatedWord(basedOn: word)  // 新的单词
//            let newColor = Color.randomCustomColor()  // 新的随机颜色
            //            self.word = newWord  // 更新绑定的单词
//            self.backgroundColor = newColor  // 更新背景颜色
//        }
    }
}
