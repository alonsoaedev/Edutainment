//
//  ContentView.swift
//  Edutainment
//
//  Created by Alonso Acosta Enriquez on 12/07/25.
//

import SwiftUI

struct MultiplicationQuestion: Hashable {
    let level: String
    let multiplier: Int
    private let _multiplicand: Int = Int.random(in: 1...12)
    private var _product: Int { multiplier * _multiplicand }
    private var _options: [String] = []
    private var _answer: String = ""
    
    init(level: String, multiplier: Int) {
        self.level = level
        self.multiplier = multiplier
        self._answer = generateAnswer(level)
        self._options = generateOptions(level)
    }
    
    private func generateAnswer(_ level: String) -> String {
        if level == "hard" {
            return "\(multiplier), \(_multiplicand)"
        }
        
        if level == "medium" {
            return "\(_multiplicand)"
        }
        
        return "\(_product)"
    }
    
    private func generateOptions(_ level: String) -> [String] {
        if level == "hard" {
            return [
                _answer,
                "\(Int.random(in: 1...12)), \(Int.random(in: 1...12))",
                "\(Int.random(in: 1...12)), \(Int.random(in: 1...12))",
            ].shuffled()
        }
        
        return [
            _answer,
            "\(Int.random(in: 1...12))",
            "\(Int.random(in: 1...12))",
        ].shuffled()
    }
    
    var question: String {
        if level == "hard" {
            return "? x ? = \(_product)"
        }
        
        if level == "medium" {
            return "\(multiplier) x ? = \(_product)"
        }
        
        return "\(multiplier) x \(_multiplicand) = ?"
    }
    
    var options: [String] {
        _options
    }
    
    func isCorrect(answer: String) -> Bool {
        return _answer == answer
    }
}


enum Route: Hashable {
    case game([MultiplicationQuestion])
}

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
            
            Text("Correct!")
                .opacity(correctAnswer ? 1 : 0)
                .animation(.easeInOut, value: correctAnswer)
        }
        .navigationTitle("Game")
        .padding()
    }
}

struct ContentView: View {
    let levels = ["easy", "medium", "hard"]
    
    @State private var tableNumber = 2
    @State private var questionsNumber = 1
    @State private var selectedLevel = "easy"
    @State private var questions: [MultiplicationQuestion] = []
    
    @State private var path = NavigationPath()
    
    func createQuestions(_ tableNumber: Int, _ questionsNumber: Int, _ level: String) -> [MultiplicationQuestion] {
        var createdQuestions: [MultiplicationQuestion] = []
        for _ in 1...questionsNumber {
            createdQuestions.append(
                MultiplicationQuestion(level: level, multiplier: tableNumber)
            )
        }
        return createdQuestions
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                
                Section("Settings") {
                    Stepper("Table number: \(tableNumber)", value: $tableNumber, in: 2...12, step: 1)
                    Stepper("Number of questions: \(questionsNumber)", value: $questionsNumber, in: 1...10)
                    Picker("Level", selection: $selectedLevel) {
                        ForEach(levels, id: \.self) { level in
                            Text("\(level)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Spacer()
                
                Button {
                    questions = createQuestions(
                        tableNumber,
                        questionsNumber,
                        selectedLevel
                    )
                    path.append(Route.game(questions))
                } label: {
                    Text("Start")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Edutainment")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .game(let questions):
                    Game(questions: questions)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
