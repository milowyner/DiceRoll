//
//  DieView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/4/21.
//

import SwiftUI

struct DieView: View {
    @ObservedObject var die: Die
    let rotation: Double
    let delay: Double
    var onFlip: ((Double) -> Void)?
    let onComplete: (Int) -> Void
    
    private let size: CGFloat = 100
    
    private struct SideLabel: AnimatableModifier {
        let die: Die
        var rotation: Double
        let size: CGFloat
        var offset: Bool = false
        let onComplete: (Int) -> Void
        let onFlip: ((Double) -> Void)?
        
        private let flips = 13.5
        
        var index: Int {
            let sides = die.sides.count
            let flip = (Int(rotation * flips) + sides - 1) - (offset ? 0 : 1)
            let index = (flip % sides + sides) % sides
            return index
        }
        
        var animatableData: Double {
            get { rotation }
            set {
                rotation = newValue
                if !offset {
                    let index = index
                    if index != die.faceIndex {
                        if Int(flips) == Int(rotation * flips) {
                            onComplete(die.sides[index])
                        } else {
                            onFlip?(rotation)
                        }
                        die.faceIndex = index
                    }
                }
            }
        }
        
        private var roll: Int {
            die.sides[index]
        }
        
        func body(content: Content) -> some View {
            if die.sides.count <= 6 {
                content.overlay(
                    Image(systemName: "die.face.\(roll).fill")
                        .resizable()
                        .frame(width: size, height: size)
                        .foregroundColor(.white)
                        // Randomly mirror the die face so it feels more natural
                        .rotation3DEffect(.degrees((die.sides[0] + Int(rotation * flips)) % 2 == 0 ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                        .background(
                            Rectangle()
                                .foregroundColor(Color(white: 0.2))
                                .frame(width: size * 0.75, height: size * 0.75)
                        )
                        .animation(nil)
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
            .modifier(SideLabel(die: die, rotation: rotation, size: size, offset: offset, onComplete: onComplete, onFlip: onFlip))
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
}

struct DieView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
