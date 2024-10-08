//
//  Array.swift
//  Versea
//
//  Created by Hazel Gong on 2024/10/8.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
