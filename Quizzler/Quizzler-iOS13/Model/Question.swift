//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Sergei Semko on 7/30/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var answer: [String]
    var correctAnswer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        self.text = q
        self.answer = a
        self.correctAnswer = correctAnswer
    }
}
