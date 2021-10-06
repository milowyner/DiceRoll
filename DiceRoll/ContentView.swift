//
//  ContentView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 9/30/21.
//

import SwiftUI

struct ContentView: View {
    private let sides = 6
    @State private var completed = false
    @State private var previousRolls = [Int]()
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    DieView(sides: sides, hapticsEnabled: true, completed: $completed) { roll in
                        if !completed {
                            previousRolls.insert(roll, at: 0)
                            completed = true
                        }
                    }
                }
                .navigationTitle("Dice Roll")
            }
            .tabItem {
                Image(systemName: "die.face.3")
                Text("Roll")
            }
            NavigationView {
                List(previousRolls, id: \.self) { roll in
                    Text("\(roll)")
                }
                .navigationTitle("Previous Rolls")
            }
            .tabItem {
                Image(systemName: "dice")
                Text("Previous")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
