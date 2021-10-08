//
//  ContentView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 9/30/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sides = 6
    @State private var previousRolls = [Int]()
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    DieView(sides: sides, hapticsEnabled: true) { roll in
                        previousRolls.insert(roll, at: 0)
                    }
                }
                .navigationTitle("Dice Roll")
            }
            .tabItem {
                Image(systemName: "die.face.3")
                Text("Roll")
            }
            
            PreviousRollsView(previousRolls: previousRolls)
                .tabItem {
                    Image(systemName: "dice")
                    Text("Previous")
                }
            
            SettingsView(sides: $sides)
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
