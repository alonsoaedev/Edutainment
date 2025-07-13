//
//  ContentView.swift
//  Edutainment
//
//  Created by Alonso Acosta Enriquez on 12/07/25.
//

import SwiftUI

struct MultiplicationQuestion {
    private let questionTemplates: [String: String] = [
        "easy": "%d x %d = ?",
        "medium": "%d x ? = %d",
        "hard": "? x ? = %d",
    ]

    let level: String
    let multiplier: Int = Int.random(in: 1...12)
    let multiplicand: Int = Int.random(in: 1...12)
    var product: Int { multiplier * multiplicand }
    
    var question: String {
        if level == "hard" {
            return "? x ? = \(product)"
        }
        
        if level == "medium" {
            return "\(multiplier) x ? = \(product)"
        }
        
        return "\(multiplier) x \(multiplicand) = ?"
    }
    
    var answer: String {
        if level == "hard" {
            return "\(multiplier),\(multiplicand)"
        }
        
        if level == "medium" {
            return "\(multiplicand)"
        }
        
        return "\(product)"
    }
    
    var options: [String] {
        if level == "hard" {
            return [
                answer,
                "\(Int.random(in: 1...12)), \(Int.random(in: 1...12))",
                "\(Int.random(in: 1...12)), \(Int.random(in: 1...12))",
            ].shuffled()
        }
        
        return [
            answer,
            "\(Int.random(in: 1...12))",
            "\(Int.random(in: 1...12))",
        ].shuffled()
    }
}

struct ContentView: View {
    let levels = ["easy", "medium", "hard"]
    
    @State private var tableNumber = 2
    @State private var questionsNumber = 1
    @State private var selectedLevel = "easy"
    @State private var questions: [MultiplicationQuestion] = []
    
    func createQuestions(_ tableNumber: Int, _ questionsNumber: Int, _ level: String) -> [MultiplicationQuestion] {
        var createdQuestions: [MultiplicationQuestion] = []
        for _ in 1...questionsNumber {
            createdQuestions.append(
                MultiplicationQuestion(level: level)
            )
        }
        return createdQuestions
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Stepper("Table number: \(tableNumber)", value: $tableNumber, in: 2...12, step: 1)
            Stepper("Number of questions: \(questionsNumber)", value: $questionsNumber, in: 1...10)
            Picker("Level", selection: $selectedLevel) {
                ForEach(levels, id: \.self) { level in
                    Text("\(level)")
                }
            }
            .pickerStyle(.segmented)
            
            Spacer()
            
            Button("Start") {
                questions = createQuestions(tableNumber, questionsNumber, selectedLevel)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
