//
//  Die.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/10/21.
//

import Foundation

class Die: Identifiable, ObservableObject {
    @Published var sides: [Int]
    
    init(sides: Int) {
        self.sides = Array(1..<sides + 1)
    }
    
    func rolled() -> Die {
        sides.shuffle()
        return self
    }
}
