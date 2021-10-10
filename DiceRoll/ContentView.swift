//
//  ContentView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 9/30/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sides = 6
    @State private var dice = 1
    @State private var previousRolls = [[Int]]()
    
    var body: some View {
        TabView {
            RollView(sides: sides, dice: dice, previousRolls: $previousRolls)
                .tabItem {
                    Image(systemName: "die.face.3")
                    Text("Roll")
                }
            
            PreviousRollsView(previousRolls: previousRolls)
                .tabItem {
                    Image(systemName: "dice")
                    Text("Previous")
                }
            
            SettingsView(sides: $sides, dice: $dice)
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
