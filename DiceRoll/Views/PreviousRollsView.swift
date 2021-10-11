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
                    if roll.dice > 1 {
                        HStack {
                            Spacer()
                            Text("Dice:")
                                .foregroundColor(.secondary)
                            Text(roll.results.map(String.init).joined(separator: ", "))
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Text("Roll:")
                            .foregroundColor(.secondary)
                        Text("\(roll.results.reduce(0, +))")
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
