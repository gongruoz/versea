//
//  GenerateNoiseImage.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/29.
//

import Foundation
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

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
