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
    @State private var showFeedback: Bool = false
    @State private var isGameOver: Bool = false
    
    var body: some View {
        VStack {
            if !isGameOver {
                Spacer()
                
                Section {
                    Text("Score")
                        .font(.largeTitle.bold())
                    Text("\(score)")
                        .font(.largeTitle.bold())
                }
                
                Spacer()
                
                Section {
                    Text("\(questions[currentQuestionIndex].question)")
                        .font(.title)
                        .padding(.bottom)
                    
                    ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                        Button {
                            showFeedback = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                showFeedback = false
                            }
                            
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
                                .font(.title)
                                .frame(maxWidth: 200)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(3)
                    }
                }
                
                Image(systemName: correctAnswer ? "checkmark.circle" : "xmark.circle")
                    .font(.title)
                    .foregroundStyle(correctAnswer ? .green : .red)
                    .animation(.easeInOut, value: correctAnswer)
                    .opacity(showFeedback ? 1 : 0)
                    .animation(.easeInOut, value: showFeedback)
                
                Spacer()
            } else {
                Text("Score")
                    .font(.largeTitle)
                Text("\(score)")
                    .font(.largeTitle)
            }
        }
        .navigationTitle("Game")
        .padding()
        .animation(.easeInOut, value: isGameOver)
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
