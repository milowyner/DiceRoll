//
//  PreviousRollsView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/8/21.
//

import SwiftUI

struct PreviousRollsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Roll.timestamp, ascending: false)],
        animation: .default)
    private var previousRolls: FetchedResults<Roll>
    
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            List(previousRolls) { roll in
                ZStack {
                    if roll.dice?.count ?? 0 > 1 {
                        HStack {
                            Spacer()
                            Text("Dice:")
                                .foregroundColor(.secondary)
                            Text(roll.dice?.map(String.init).joined(separator: ", ") ?? "")
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Text("Roll:")
                            .foregroundColor(.secondary)
                        Text("\(roll.dice?.reduce(0, +) ?? 0)")
                            .font(.headline)
                        Spacer()
                        Text("\(roll.sides)-sided")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Clear previous rolls?"),
                      message: Text("This cannot be undone."),
                      primaryButton: .cancel(),
                      secondaryButton: .destructive(Text("Clear"), action: clear))
            }
            .navigationTitle("Previous Rolls")
            .navigationBarItems(trailing: Button("Clear") {
                showingAlert = true
            }.disabled(previousRolls.isEmpty))
        }
    }
    
    private func clear() {
        previousRolls.forEach(viewContext.delete)
        PersistenceController.shared.save()
    }
}
