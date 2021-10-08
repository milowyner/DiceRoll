//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/6/21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var sides: Int
    private let types = [4, 6, 8, 10, 12, 20, 100]
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Dice Type:")
                    Spacer()
                    Picker("", selection: $sides) {
                        ForEach(types, id: \.self) { sides in
                            Text("\(sides)-sided").tag(sides)
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
        SettingsView(sides: .constant(6))
    }
}
