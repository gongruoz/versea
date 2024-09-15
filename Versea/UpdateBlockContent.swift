//
//  UpdateBlockContent.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.
//

func updateBlockContent() {
    LLMAPIManager.shared.fetchWord { [weak self] newWord in
        self?.word = newWord
        self?.wordLabel.text = newWord
        self?.backgroundColor = .randomBlueShade()
    }
}
