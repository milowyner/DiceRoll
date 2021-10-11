//
//  RollView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/8/21.
//

import SwiftUI
import CoreHaptics

struct RollView: View {
    @ObservedObject var holder: DiceHolder
    @Binding var previousRolls: [Roll]
    
    @State private var results = [Int]()
    @State private var engine: CHHapticEngine?
        
    var body: some View {
        NavigationView {
            VStack {
                ForEach(0..<holder.numberOfDice, id: \.self) { dieIndex in
                    DieView(die: holder.dice[dieIndex], rotation: holder.rotation, delay: Double(dieIndex) * 0.25, onFlip: onFlip(dieIndex)) { roll in
                        DispatchQueue.main.async {
                            results.append(roll)
                            playHaptics(intensity: 0.6)
                            
                            if dieIndex == holder.numberOfDice - 1 {
                                let roll = Roll(sides: holder.numberOfSides, dice: holder.numberOfDice, results: results)
                                previousRolls.insert(roll, at: 0)
                                results = []
                            }
                        }
                    }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                prepareHaptics()
                holder.rollDice()
                holder.rotation = 0
                withAnimation {
                    holder.rotation = 1
                }
            }
            .navigationTitle("Dice Roll")
        }
    }
    
    func onFlip(_ dieIndex: Int) -> ((Double) -> Void)? {
        dieIndex == 0 ? { rotation in
            playHaptics(intensity: Double(rotation) * 0.3 + 0.3)
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
