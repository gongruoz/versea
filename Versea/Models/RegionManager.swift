//
//  RegionManager.swift
//  Versea
//
//  Created by Hazel Gong on 2024/10/10.
//

import Foundation

struct ScreenID: Hashable, CustomStringConvertible {
    let x: Int
    let y: Int

    var description: String {
        return "(\(x), \(y))"
    }
}

// Step 3: Implement the RegionManager class
class RegionManager: ObservableObject {
    // use a dictionary to store all the ScreenStates
    @Published var screenStates: [ScreenID: ScreenState] = [:]          // Use the shared ScreenID type
    @Published var activeScreens: Set<ScreenID> = []

    // Create or retrieve a ScreenState for a given screen ID
    func getScreenState(at screenID: ScreenID) -> ScreenState {
            // Check if the screen state already exists in the dictionary
            if let screenState = screenStates[screenID] {
                return screenState
            } else {
                // Create a new ScreenState, store it, and return it
                let newScreenState = ScreenState(screenID: screenID)
                screenStates[screenID] = newScreenState
                return newScreenState
            }
        }

}
