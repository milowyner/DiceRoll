//
//  DieView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/4/21.
//

import SwiftUI
import CoreHaptics

struct DieView: View {
    let sides: Int
    let rotation: Double
    let delay: Double
    var hapticsEnabled: Bool
    let onComplete: (Int) -> Void
    
    @State private var array: [Int]
    @State private var engine: CHHapticEngine?
    
    private let size: CGFloat = 100
    
    init(sides: Int, rotation: Double, delay: Double, hapticsEnabled: Bool = false, onComplete: @escaping (Int) -> Void = { _ in }) {
        self.sides = sides
        self.rotation = rotation
        self.delay = delay
        self.hapticsEnabled = hapticsEnabled
        self.onComplete = onComplete
        array = [Int](1...sides)
    }
    
    private struct SideLabel: AnimatableModifier {
        let sides: Int
        var rotation: Double
        let array: [Int]
        let size: CGFloat
        var offset: Bool = false
        let onComplete: (Int) -> Void
        let hapticsEnabled: Bool
        let playHaptics: (Float) -> Void
        
        class LastIndex {
            var value = 0
        }
        var lastIndex = LastIndex()
        
        private let flips = 13.5
        
        var index: Int {
            var index = Int(rotation * flips + Double(sides - 1) + (offset ? 1 : 0)) % sides
            if index < 0 { index = 0 }
            return index
        }
        
        var animatableData: Double {
            get { rotation }
            set {
                rotation = newValue
                if !offset {
                    let index = index
                    if index != lastIndex.value {
                        if hapticsEnabled {
                            playHaptics(Float(rotation * 0.6 + 0.4))
                        }
                        if Int(flips) == Int(rotation * flips) {
                            onComplete(array[index])
                        }
                        lastIndex.value = index
                    }
                }
            }
        }
        
        private var roll: Int {
            array.count == sides ? array[index] : sides
        }
        
        func body(content: Content) -> some View {
            if sides <= 6 {
                content.overlay(
                    Image(systemName: "die.face.\(roll).fill")
                        .resizable()
                        .frame(width: size, height: size)
                        .foregroundColor(.white)
                        .background(
                            Rectangle()
                                .foregroundColor(Color(white: 0.2))
                                .frame(width: size * 0.75, height: size * 0.75)
                        )
                )
                    .shadow(color: .clear, radius: 0)
            } else {
                content.overlay(
                    Text("\(roll)")
                        .font(.system(size: 60, weight: .semibold, design: .rounded))
                        .minimumScaleFactor(0.5)
                        .allowsTightening(true)
                        .foregroundColor(Color(white: 0.2))
                        .padding(8)
                        .animation(nil)
                )
            }
        }
    }
    
    func sideView(offset: Bool = false) -> some View {
        Rectangle()
            .fill(.white)
            .frame(width: size, height: size)
            .modifier(SideLabel(sides: sides, rotation: rotation, array: array, size: size, offset: offset, onComplete: onComplete, hapticsEnabled: hapticsEnabled, playHaptics: playHaptics))
            .animation(rotation == 0 ? nil : .easeOut(duration: 2).delay(delay))
            .overlay(offset ? Color.black.opacity(rotation * 0.25)
                     : Color.white.opacity(rotation * -0.5 + 0.5))
            .rotation3DEffect(
                .degrees(rotation * 90 - (offset ? 0 : 90)),
                axis: (x: 0, y: 1, z: 0),
                anchor: offset ? .leading : .trailing,
                anchorZ: 0, perspective: 1
            )
            .offset(x: rotation * size - (offset ? 0 : size))
            .animation(rotation == 0 ? nil : .easeInOut(duration: 2).delay(delay))
    }
    
    // Used to make the die not appear to shrink when rotating
    private struct ScaleEffect: GeometryEffect {
        var scale: Double
        
        var animatableData: CGFloat {
            get { scale }
            set { scale = newValue }
        }
        
        func effectValue(size: CGSize) -> ProjectionTransform {
            let scale = -pow(scale - 0.5, 2) + 1.25
            let offset = size.width / 2
            let transform = CGAffineTransform(translationX: offset, y: offset)
                .scaledBy(x: scale, y: scale)
                .translatedBy(x: -offset, y: -offset)
            return ProjectionTransform(transform)
        }
    }
    
    var body: some View {
        ZStack {
            sideView(offset: true)
            sideView()
        }
        // Uncomment these to make the die not appear to shrink when rotating
//        .modifier(ScaleEffect(scale: rotation))
//        .animation(rotation == 0 ? nil : .easeInOut(duration: 2))
        .shadow(color: Color(white: 0.5), radius: 70, x: size / 2, y: size / 4)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    
    func playHaptics(intensity: Float) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
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

struct DieView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
