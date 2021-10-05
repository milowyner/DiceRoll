//
//  ContentView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 9/30/21.
//

import SwiftUI

struct ContentView: View {
    private let sides = 6
    
    var body: some View {
        TabView {
            DieView(sides: sides)
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
