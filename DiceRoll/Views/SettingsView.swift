//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/6/21.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var holder: DiceHolder
    private let sidesOptions = [4, 6, 8, 10, 12, 20, 100]
    private let diceOptions = [1, 2, 3]
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Dice Type")
                    Spacer()
                    Picker("", selection: $holder.numberOfSides) {
                        ForEach(sidesOptions, id: \.self) { sides in
                            Text("\(sides)-sided").tag(sides)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                HStack {
                    Text("Number of Dice")
                    Spacer()
                    Picker("", selection: $holder.numberOfDice) {
                        ForEach(diceOptions, id: \.self) { dice in
                            Text("\(dice) di\(dice > 1 ? "c" : "")e").tag(dice)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(holder: DiceHolder())
    }
}
