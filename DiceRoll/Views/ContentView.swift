//
//  ContentView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 9/30/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var diceHolder = DiceHolder()
    
    var body: some View {
        TabView {
            RollView(holder: diceHolder)
                .tabItem {
                    Image(systemName: "die.face.3")
                    Text("Roll")
                }
            
            PreviousRollsView()
                .tabItem {
                    Image(systemName: "dice")
                    Text("Previous")
                }
            
            SettingsView(holder: diceHolder)
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
