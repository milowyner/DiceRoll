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
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    DieView(sides: sides, hapticsEnabled: true, completed: $completed)
                    DieView(sides: sides, completed: $completed)
                    DieView(sides: sides, completed: $completed)
                }
                .navigationTitle("Dice Roll")
            }
            .tabItem {
                Image(systemName: "die.face.3")
                Text("Roll")
            }
            
            Text("Hello")
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
