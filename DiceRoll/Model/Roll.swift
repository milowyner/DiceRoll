//
//  Roll.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/11/21.
//

import Foundation

struct Roll: Identifiable {
    let id = UUID()
    
    let sides: Int
    let dice: Int
    let results: [Int]
}
