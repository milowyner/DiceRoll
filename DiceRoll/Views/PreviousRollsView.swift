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
                HStack {
                    Text("Roll:")
                        .foregroundColor(.secondary)
                    Text("\(roll.dice?.reduce(0, +) ?? 0)")
                        .font(.headline)
                    if roll.dice?.count ?? 0 > 1 {
                        Text("Dice:")
                            .foregroundColor(.secondary)
                            .padding(.leading, 8)
                        Text(roll.dice?.map(String.init).joined(separator: ", ") ?? "")
                            .padding(.trailing, 8)
                    }
                    Spacer()
                    Text("\(roll.sides)-sided")
                        .foregroundColor(.secondary)
                }
                .padding(.trailing, 8)
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

struct PreviousRollsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousRollsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
