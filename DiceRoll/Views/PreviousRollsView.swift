//
//  PreviousRollsView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/8/21.
//

import SwiftUI

struct PreviousRollsView: View {
    let previousRolls: [Roll]
    
    var body: some View {
        NavigationView {
            List(previousRolls) { roll in
                ZStack {
                    if roll.dice.count > 1 {
                        HStack {
                            Spacer()
                            Text("Dice:")
                                .foregroundColor(.secondary)
                            Text(roll.dice.map(String.init).joined(separator: ", "))
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Text("Roll:")
                            .foregroundColor(.secondary)
                        Text("\(roll.dice.reduce(0, +))")
                            .font(.headline)
                        Spacer()
                        Text("\(roll.sides)-sided")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Previous Rolls")
        }
    }
}
