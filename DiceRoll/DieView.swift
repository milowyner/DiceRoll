//
//  DieView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/4/21.
//

import SwiftUI

struct DieView: View {
    let die: Int
    let rotation: Double
    let array: [Int]
    private let size: CGFloat = 100
    
    private struct DieLabel: AnimatableModifier {
        let die: Int
        var rotation: Double
        let array: [Int]
        let size: CGFloat
        var offset: Bool = false
        
        var animatableData: Double {
            get { rotation }
            set { rotation = newValue }
        }
        
        private var roll: Int {
            return array[Int(rotation * 15.5 + (offset ? 1 : 0)) % die]
        }
        
        func body(content: Content) -> some View {
            content
                .overlay(
                    Image(systemName: "die.face.\(roll).fill")
                        .resizable()
                        .frame(width: size, height: size)
                        .foregroundColor(.gray)
                        .background(
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: size * 0.75, height: size * 0.75)
                        )
                )
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: size, height: size)
                .modifier(DieLabel(die: die, rotation: rotation, array: array, size: size, offset: true))
                .animation(rotation == 0 ? nil : .easeOut(duration: 2))
                .overlay(Color.black.opacity(rotation * 0.5))
                .rotation3DEffect(.degrees(rotation * 90), axis: (x: 0, y: 1, z: 0), anchor: .leading, anchorZ: 0, perspective: 1)
                .offset(x: rotation * size)
                .animation(rotation == 0 ? nil : .easeInOut(duration: 2))

            Rectangle()
                .fill(Color.gray)
                .frame(width: size, height: size)
                .modifier(DieLabel(die: die, rotation: rotation, array: array, size: size))
                .animation(rotation == 0 ? nil : .easeOut(duration: 2))
                .overlay(Color.white.opacity(rotation * -0.5 + 0.5))
                .rotation3DEffect(.degrees(rotation * 90 - 90), axis: (x: 0, y: 1, z: 0), anchor: .trailing, anchorZ: 0, perspective: 1)
                .offset(x: rotation * size - size)
                .animation(rotation == 0 ? nil : .easeInOut(duration: 2))
        }
    }
}

struct DieView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
