//
//  MultiplicationQuestion.swift
//  Edutainment
//
//  Created by Alonso Acosta Enriquez on 13/10/25.
//

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
