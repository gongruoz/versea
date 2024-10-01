//
//  CanvasViewModel.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/29.
//

import Foundation
import SwiftUI

class CanvasViewModel: ObservableObject {
    @Published private var model: GridModel
    
    var grid: [[String]] { model.grid }
    var sentence: String { model.sentence }
    
    init() {
        self.model = GridModel(sentence: GridModel.initialSentence())
    }
    
    func regenerateGrid() {
        model.regenerate()
        objectWillChange.send()
    }
}
