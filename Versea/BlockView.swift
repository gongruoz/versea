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
    @Binding var word: String  // 用 @Binding 管理外部的 word
    @State var backgroundColor: Color  // 用 @State 管理颜色的状态

    var body: some View {
        ZStack {
            // 添加噪音颗粒效果
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
            // 当点击时，生成新的内容
//            let newWord = generateRelatedWord(basedOn: word)  // 新的单词
            let newColor = Color.randomCustomColor()  // 新的随机颜色
//            self.word = newWord  // 更新绑定的单词
            self.backgroundColor = newColor  // 更新背景颜色
        }
    }

    // 生成相关文本的方法
//    func generateRelatedWord(basedOn word: String) -> String {
//        // 简单词库示例
//        let wordDictionary: [String: [String]] = [
//            "SILENT": ["SCREAMING", "INVISIBLE", "ELECTRIC"],
//            "MOON": ["DISCO BALL", "DOORWAY", "MUSHROOM"],
//            "HUMS": ["BURNS", "VANISHES", "EXPLODES", "CHIMES"],
//            "LOW": ["FLOATING", "DRUNK", "SQUASHED"],
//            "FOOTSTEPS": ["PAW PRINTS", "CRACKS", "STITCHES"],
//            "VANISH": ["SHATTER", "GROW WINGS", "ERASE"],
//            "IN": ["DANCING WITH", "BEYOND"],
//            "THE": ["ITS", "A", "HER", "OUR", "ANY"],
//            "WAVES": ["GLASS SHARDS", "CIRCLES", "FIREWORKS", "FINGERTIPS"],
//            "STARS": ["BUBBLES", "COINS", "SPIDER"],
//            "BLINK": ["DISAPPEAR", "BURST", "EVAPORATE", "TILT"],
//            "THEN": ["SUDDENLY", "MAYBE"],
//            "FORGET": ["FORGIVE", "DROWN", "FREEZE", "EVOLVE"]
//        ]
//        return wordDictionary[word.uppercased()]?.randomElement() ?? word
//    }

    // 生成噪音的函数并返回 UIImage
    func generateNoiseImage() -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.randomGenerator()

        if let noiseImage = filter.outputImage?.cropped(to: CGRect(x: 0, y: 0, width: 200, height: 200)) {
            let whitenVector = CIVector(x: 0, y: 0, z: 0, w: 0)
            let fineGrain = CIVector(x: 0, y: 0.06, z: 0, w: 0)
            let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
            let whiteningFilter = CIFilter.colorMatrix()
            whiteningFilter.inputImage = noiseImage
            whiteningFilter.rVector = whitenVector
            whiteningFilter.gVector = whitenVector
            whiteningFilter.bVector = whitenVector
            whiteningFilter.aVector = fineGrain
            whiteningFilter.biasVector = zeroVector

            if let whitenedNoise = whiteningFilter.outputImage {
                if let cgImage = context.createCGImage(whitenedNoise, from: whitenedNoise.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
}

extension Color {
    static func randomCustomColor() -> Color {
        let hexColors = [
            "D9ABE7", "F1EC75", "FF7A2F", "B38DFF",
            "26B5E9", "7BCDAB", "AFD3B3", "D8B8CE",
            "EBC443", "E6819B", "B798CA", "DC8F4B",
            "FF7B69", "2365AF"
        ]

        let randomHex = hexColors.randomElement() ?? "000000"
        return Color.fromHex(randomHex)
    }

    static func fromHex(_ hex: String) -> Color {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }

        guard hexFormatted.count == 6 else {
            return Color.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        return Color(red: red, green: green, blue: blue)
    }
}
