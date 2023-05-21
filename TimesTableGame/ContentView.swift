//
//  ContentView.swift
//  TimesTableGame
//
//  Created by user239371 on 5/20/23.
//

import SwiftUI

struct timesTableQuestion {
    let question: String
    let answer: Int
    }

func createQuestions(max: Int, times: Int) -> [timesTableQuestion] {
    var newQuestions:[timesTableQuestion] = []
    
    for _ in 0..<times {
        let lower = Int.random(in: 1...max)
        let upper = Int.random(in: 1...max)
        
        newQuestions.append(timesTableQuestion(question: "What is \(lower) * \(upper)", answer: upper * lower))
    }
    return newQuestions
}

struct ContentView: View {
@State var upperBound = 10
@State var questionCount = 0
@State var currentQuestionIndex = 0
@State var inputAnswer = ""
@State var questions: [timesTableQuestion] = []
@State var score = 0

    func restartGame() {
        questionCount = 0
        score = 0
        questions = []
    }
    
    func submitAnswer() {
        let currentQuestion = questions[currentQuestionIndex]
        guard let userAnswer = Int(inputAnswer) else {
            return
        }
        if userAnswer == currentQuestion.answer {
            score += 1
        }
        inputAnswer = ""
        currentQuestionIndex += 1
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Which times tables do you want to practice?")
                .padding()
                .font(.title3)
                .bold()

            Stepper("\(upperBound) Times Table", value: $upperBound, in: 2...12)
                .padding()
                .font(.title3)

            Text("How many questions do you want to solve?")
                .padding()
                .font(.title3)
                .bold()
               
            HStack(alignment: .center, spacing: 20) {
                Button("5") {
                    restartGame()
                    questions = createQuestions(max: upperBound, times: 5)
                    currentQuestionIndex = 0
                    
                }
                .frame(width: 100, height: 50)
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Button("10") {
                    restartGame()
                    questions = createQuestions(max: upperBound, times: 10)
                    currentQuestionIndex = 0
                }
                .frame(width: 100, height: 50)
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Button("20") {
                    restartGame()
                    questions = createQuestions(max: upperBound, times: 20)
                    currentQuestionIndex = 0
                }
                .frame(width: 100, height: 50)
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
            
            if currentQuestionIndex < questions.count {
                Text(questions[currentQuestionIndex].question)
            }
            
            TextField("Answer: ", text: $inputAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disabled(currentQuestionIndex >= questions.count)
                .onSubmit {
                    submitAnswer()
                }
                .padding(10)
            
            Text("Question \(currentQuestionIndex) of \(questions.count)")
                .padding()
                .font(.title3)


            Text("Score is \(score)")
                .padding()
                .bold()
                .font(.title3)

        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
