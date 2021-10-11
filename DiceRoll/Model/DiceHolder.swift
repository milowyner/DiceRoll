//
//  DiceHolder.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/10/21.
//

import Foundation

class DiceHolder: ObservableObject {
    var numberOfSides: Int {
        didSet { createDice() }
    }
    var numberOfDice: Int {
        didSet { createDice() }
    }
    @Published var dice = [Die]()
    
    init(sides: Int = 6, numberOfDice: Int = 1) {
        self.numberOfSides = sides
        self.numberOfDice = numberOfDice
        print("init DiceHolder")
        createDice()
    }
    
    private func createDice() {
        print("createDice")
        dice = (0..<numberOfDice).map { _ in Die(sides: numberOfSides) }
    }
    
    func rollDice(withDelay delay: Double = 0) {
        for i in 0..<dice.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * delay) {
                self.dice[i] = self.dice[i].rolled()
            }
        }
    }
}
