//
//  RollView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/8/21.
//

import SwiftUI
import CoreHaptics

struct RollView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var holder: DiceHolder
    @Binding var haptics: HapticsStrength
    
    @State private var results = [Int]()
    @State private var engine: CHHapticEngine?
        
    var body: some View {
        NavigationView {
            VStack {
                ForEach(0..<holder.numberOfDice, id: \.self) { dieIndex in
                    DieView(die: holder.dice[dieIndex], onFlip: onFlip(dieIndex)) { roll in
                        DispatchQueue.main.async {
                            results.append(roll)
                            playHaptics(intensity: haptics.strength)
                            
                            if dieIndex == holder.numberOfDice - 1 {
                                let roll = Roll(context: viewContext)
                                roll.sides = Int16(holder.numberOfSides)
                                roll.dice = results
                                roll.timestamp = Date()
                                
                                PersistenceController.shared.save()
                                results = []
                            }
                        }
                    }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                prepareHaptics()
                holder.rollDice(withDelay: 0.25)
            }
            .navigationTitle("Dice Roll")
        }
    }
    
    func onFlip(_ dieIndex: Int) -> ((Double) -> Void)? {
        dieIndex == 0 ? { rotation in
            playHaptics(intensity: rotation * haptics.strength / 2 + haptics.strength / 2)
        } : nil
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func playHaptics(intensity: Double, sharpness: Double = 1.0) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(intensity))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(sharpness))
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
