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
            if isGameOver {
                Text("Score")
                    .font(.largeTitle)
                Text("\(score)")
                    .font(.largeTitle)
            } else {
                Spacer()
                
                Section {
                    Text("Score")
                        .font(.largeTitle.bold())
                    Text("\(score)")
                        .font(.largeTitle.bold())
                    Text("\(currentQuestionIndex)/\(questions.count)")
                }
                
                Spacer()
                
                Section {
                    Text("\(questions[currentQuestionIndex].question)")
                        .font(.title)
                        .padding(.bottom)
                    
                    ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                        Button {
                            correctAnswer = questions[currentQuestionIndex].isCorrect(answer: option)
                            score = correctAnswer ? score + 1 : score
                            showFeedback = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                showFeedback = false
                            }
                            
                            if currentQuestionIndex + 1 < questions.count {
                                currentQuestionIndex += 1
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    isGameOver = true
                                }
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
                    .opacity(showFeedback ? 1 : 0)
                    .animation(.easeInOut, value: showFeedback)
                
                Spacer()
            }
        }
        .navigationTitle("Game")
        .padding()
        .animation(.easeInOut(duration: 2), value: isGameOver)
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
