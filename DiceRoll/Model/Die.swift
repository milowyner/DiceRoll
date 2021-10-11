//
//  Die.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/10/21.
//

import SwiftUI

class Die: Identifiable, ObservableObject {
    @Published var sides: [Int]
    @Published var rotation = 0.0
    var faceIndex: Int
    
    init(sides: Int) {
        self.sides = Array(1..<sides + 1)
        faceIndex = sides - 1
    }
    
    func rolled() -> Die {
        sides.shuffle()
        rotation = 0
        withAnimation {
            rotation = 1
        }
        return self
    }
}
