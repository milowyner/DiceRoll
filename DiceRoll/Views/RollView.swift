//
//  RollView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/8/21.
//

import SwiftUI

struct RollView: View {
    @ObservedObject var holder: DiceHolder
    @State private var currentRoll = [Int]()
    @Binding var previousRolls: [[Int]]
    
    @State private var rotation = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(0..<holder.numberOfDice, id: \.self) { dieIndex in
                    DieView(die: holder.dice[dieIndex], rotation: rotation, delay: Double(dieIndex) * 0.25, hapticsEnabled: /*die == 0*/ false) { roll in
                        DispatchQueue.main.async {
                            currentRoll.append(roll)
                            
                            if dieIndex == holder.numberOfDice - 1 {
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
                holder.rollDice()
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
