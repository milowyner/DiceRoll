//
//  RollView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/8/21.
//

import SwiftUI

struct RollView: View {
    let sides: Int
    let dice: Int
    @State private var currentRoll = [Int]()
    @Binding var previousRolls: [[Int]]
    
    @State private var rotation = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(0..<dice, id: \.self) { die in
                    DieView(sides: sides, rotation: rotation, delay: Double(die) * 0.5, hapticsEnabled: /*die == 0*/ false) { roll in
                        DispatchQueue.main.async {
                            currentRoll.append(roll)
                            
                            if die == dice - 1 {
                                previousRolls.insert(currentRoll, at: 0)
                                currentRoll = []
                            }
                        }
                    }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
//                prepareHaptics()
//                array = [Int](1...sides).shuffled()
                rotation = 0
                withAnimation {
                    rotation = 1
                }
            }
            .navigationTitle("Dice Roll")
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
