//
//  ContentView.swift
//  indicateValueWithSlider
//
//  Created by Таня Кожевникова on 13.08.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var targetValue = Int.random(in: 1...100)
    @State private var currentValue = 50.0
    @State private var showAlert = false
    
    var body : some View {
        VStack {
            GameSlider(
                currentValue: $currentValue,
                targetValue: targetValue,
                color: .red,
                alpha: computerScore()
            )
            
            ButtonView(
                showAlert: $showAlert,
                title: "Проверь меня",
                currentScore: computerScore(),
                action: { showAlert = true }
            )
            
            ButtonView(title: "Начать заново") {
                targetValue = Int.random(in: 1...100)
            }
        }
    }
    
    private func computerScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
}

struct ButtonView : View {
    @Binding var showAlert : Bool
    let title : String
    let currentScore : Int
    let action : () -> Void
    
    var body: some View {
        Button(title, action: action)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Your Score"),
                    message: Text("\(currentScore)")
                )
            }
            .padding()
    }
    
    init(showAlert: Binding<Bool> = .constant(false), title: String, currentScore: Int = 0, action: @escaping () -> Void) {
        self._showAlert = showAlert
        self.title = title
        self.currentScore = currentScore
        self.action = action
    }
}

#Preview {
    ContentView()
}
