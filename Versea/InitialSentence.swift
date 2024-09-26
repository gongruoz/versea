//
//  InitialSentence.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/24.
//

import SwiftUI

func initialSentence() -> String {
    let questions = [
        "WHAT REMAINS WHEN ALL I CLING TO DISAPPEARS",
        "WHO AM I BENEATH THE STORIES I TELL MYSELF",
        "HOW DOES SILENCE SHAPE THE MEANING OF MY WORDS",
        "WHAT WOULD I SEEK IF FEAR NO LONGER HELD SWAY",
        "WHERE DOES MY PATH LEAD WHEN I STOP SEARCHING",
        "HOW DO I DEFINE FREEDOM WHEN NOTHING BINDS ME",
        "WHAT TRUTH DO I AVOID IN THE COMFORT OF HABIT",
        "DOES TIME CHANGE WHEN I CEASE TO MEASURE IT",
        "DO YOU HEAR THE SOUND OF TIME"
    ]
    
    return questions.randomElement() ?? ""
}
