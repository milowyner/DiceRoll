//
//  ContentView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 9/30/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var diceHolder = DiceHolder()
    @State private var haptics: HapticsStrength = {
        if let value = UserDefaults.standard.value(forKey: "Haptics") as? Double,
           let haptics = HapticsStrength(rawValue: value) {
            return haptics
        } else {
            return .normal
        }
    }()
    
    var body: some View {
        TabView {
            RollView(holder: diceHolder, haptics: $haptics)
                .tabItem {
                    Image(systemName: "die.face.3")
                    Text("Roll")
                }
            
            PreviousRollsView()
                .tabItem {
                    Image(systemName: "dice")
                    Text("Previous")
                }
            
            SettingsView(holder: diceHolder, haptics: $haptics)
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
