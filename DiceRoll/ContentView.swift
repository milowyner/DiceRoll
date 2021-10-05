//
//  ContentView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 9/30/21.
//

import SwiftUI

struct ContentView: View {
    private let die = 6
    @State private var rotation = 0.0
    @State private var array: [Int]
    
    init() {
        array = [Int](1...die).shuffled()
    }
    
    var body: some View {
        DieView(die: die, rotation: rotation, array: array)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                array.shuffle()
                rotation = 0
                withAnimation {
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
