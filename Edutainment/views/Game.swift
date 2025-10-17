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
    @State private var score: Int = 0
    @State private var isGameStarted: Bool = false
    @State private var isGameOver: Bool = false
    
    var body: some View {
        VStack {
            if !isGameOver {
                Section("Score") {
                    Text("\(score)")
                }
                
                Section("Question") {
                    Text("\(questions[currentQuestionIndex].question)")
                }
                
                Section ("Options") {
                    ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                        Button {
                            isGameStarted = true
                            
                            correctAnswer = questions[currentQuestionIndex].isCorrect(answer: option)
                            if currentQuestionIndex < questions.count - 1 {
                                currentQuestionIndex += 1
                            }
                            if correctAnswer {
                                score += 1
                            }
                            if currentQuestionIndex == questions.count - 1 {
                                isGameOver = true
                            }
                        } label: {
                            Text(option)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                Image(systemName: correctAnswer ? "checkmark.circle" : "xmark.circle")
                    .foregroundStyle(correctAnswer ? .green : .red)
                    .animation(.easeInOut, value: correctAnswer)
                    .opacity(isGameStarted ? 1 : 0)
                    .animation(.easeInOut, value: isGameStarted)
            } else {
                Text("Score")
                    .font(.largeTitle)
                Text("\(score)")
                    .font(.largeTitle)
            }
        }
        .navigationTitle("Game")
        .padding()
    }
}

#Preview {
    Game(questions: [
        MultiplicationQuestion(level: "easy", multiplier: 2),
        MultiplicationQuestion(level: "easy", multiplier: 2),
        MultiplicationQuestion(level: "easy", multiplier: 2),
        MultiplicationQuestion(level: "easy", multiplier: 2),
        MultiplicationQuestion(level: "easy", multiplier: 2),
    ])
}
