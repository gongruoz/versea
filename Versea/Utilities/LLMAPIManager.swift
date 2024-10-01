//
//  LLMAPIManager.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/15.
//

import Foundation

class LLMAPIManager {
    
    static let shared = LLMAPIManager()
    
    private init() {}
    
    func fetchWord(completion: @escaping (String) -> Void) {
        // Simulate an LLM API call
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let generatedWord = "GeneratedWord" // This would be the API response
            DispatchQueue.main.async {
                completion(generatedWord)
            }
        }
    }
}
