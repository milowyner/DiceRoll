//
//  ContentView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 9/30/21.
//

import SwiftUI

struct ContentView: View {
    private let size: CGFloat = 100
    @State private var rotation = 0.0
    @State private var roll = 0
    let die = 6
    
    private static let frames = 20
        
    func rollDie() -> Int {
        Int.random(in: 1...die)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: size, height: size)
                .overlay(
                    Image(systemName: "die.face.\((roll + 1) % die + 1).fill")
                        .resizable()
                        .frame(width: size, height: size)
                        .foregroundColor(.gray)
                        .background(
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: size * 0.75, height: size * 0.75)
                        )
                )
                .overlay(Color.black.opacity(rotation * 0.5))
                .rotation3DEffect(.degrees(rotation * 90), axis: (x: 0, y: 1, z: 0), anchor: .leading, anchorZ: 0, perspective: 1)
                .offset(x: rotation * size)

            Rectangle()
                .fill(Color.gray)
                .frame(width: size, height: size)
                .overlay(
                    Image(systemName: "die.face.\(roll).fill")
                        .resizable()
                        .frame(width: size, height: size)
                        .foregroundColor(.gray)
                        .background(
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: size * 0.75, height: size * 0.75)
                        )
                )
                .overlay(Color.white.opacity(rotation * -0.5 + 0.5))
                .rotation3DEffect(.degrees(rotation * 90 - 90), axis: (x: 0, y: 1, z: 0), anchor: .trailing, anchorZ: 0, perspective: 1)
                .offset(x: rotation * size - size)
        }
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
            withAnimation(.easeInOut(duration: 2.3)) {
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
