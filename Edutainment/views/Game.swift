//
//  Game.swift
//  Edutainment
//
//  Created by Alonso Acosta Enriquez on 13/10/25.
//

import SwiftUI

struct Game: View {
    let questions: [MultiplicationQuestion]
    
    @State private var currentQuestionIndex: Int = 0
    @State private var correctAnswer: Bool = false
    
    var body: some View {
        VStack {
            Section("Question") {
                Text("\(questions[currentQuestionIndex].question)")
            }
            
            Section ("Options") {
                ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                    Button {
                        correctAnswer = questions[currentQuestionIndex].isCorrect(answer: option)
                        if currentQuestionIndex < questions.count - 1 {
                            currentQuestionIndex += 1
                        }
                    } label: {
                        Text(option)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle("Game")
        .padding()
    }
}
