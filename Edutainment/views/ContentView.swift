//
//  ContentView.swift
//  Edutainment
//
//  Created by Alonso Acosta Enriquez on 12/07/25.
//

import SwiftUI

enum Route: Hashable {
    case game([MultiplicationQuestion])
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
