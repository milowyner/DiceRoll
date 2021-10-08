//
//  PreviousRollsView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/8/21.
//

import SwiftUI

struct PreviousRollsView: View {
    let previousRolls: [Int]
    
    var body: some View {
        NavigationView {
            List(previousRolls, id: \.self) { roll in
                Text("\(roll)")
            }
            .navigationTitle("Previous Rolls")
        }
    }
}
