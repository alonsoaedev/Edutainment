//
//  ContentView.swift
//  Edutainment
//
//  Created by Alonso Acosta Enriquez on 12/07/25.
//

import SwiftUI

struct ContentView: View {
    let levels = ["easy", "medium", "hard"]
    
    @State private var tableNumber = 2
    @State private var questionsNumber = 1
    @State private var selectedLevel = "easy"
    
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
            
            Button("Start") {}
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
