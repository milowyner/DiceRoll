//
//  ContentView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 9/30/21.
//

import SwiftUI

struct ContentView: View {
    private let die = 6
    @State private var rotation = 0.0
    @State private var roll = 0
    
    private static let frames = 20
        
    func rollDie() -> Int {
        Int.random(in: 1...die)
    }
    
    var body: some View {
        DieView(die: die, rotation: rotation, roll: roll)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                let actualRoll = rollDie()
                
                // Roll animation
                for i in 1...Self.frames {
                    let delay = Double(i * i) / Double(Self.frames) / 10.0
                    print(delay)
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        var animationRoll = roll
                        while animationRoll == roll {
                            animationRoll = rollDie()
                        }
                        if i == Self.frames {
                            roll = actualRoll
                        } else {
                            roll = animationRoll
                        }
                    }
                }
                
                // Rotate animation
                rotation = 0
                withAnimation(.easeOut(duration: 2.3)) {
                    rotation = 1
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
