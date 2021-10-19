//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/6/21.
//

import SwiftUI

enum HapticsStrength: Double, CaseIterable, Identifiable {
    case off = 0
    case weak = 0.5
    case normal = 0.75
    case strong = 1.0

    var id: Double { rawValue }
    var strength: Double { rawValue }
}

struct SettingsView: View {
    @ObservedObject var holder: DiceHolder
    @Binding var haptics: HapticsStrength
    
    private let sidesOptions = [4, 6, 8, 10, 12, 20, 100]
    private let diceOptions = [1, 2, 3, 4, 5, 6]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dice Settings")) {
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
                    
                    VStack(alignment: .leading) {
                        Text("Number of Dice")
                        Picker("", selection: $holder.numberOfDice) {
                            ForEach(diceOptions, id: \.self) { dice in
                                Text("\(dice)").tag(dice)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: haptics) { strength in
                            UserDefaults.standard.set(strength.rawValue, forKey: "Haptics")
                        }
                    }
                    .padding(.vertical, 6)
                }
                
                Section(header: Text("Haptics Strength")) {
                    VStack {
                        Picker("", selection: $haptics) {
                            ForEach(HapticsStrength.allCases) { strength in
                                Text(String(describing: strength).capitalized).tag(strength)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: haptics) { strength in
                            UserDefaults.standard.set(strength.rawValue, forKey: "Haptics")
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(holder: DiceHolder(), haptics: .constant(.normal))
    }
}
