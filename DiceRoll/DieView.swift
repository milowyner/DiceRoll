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
    let roll: Int
    private let size: CGFloat = 100
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: size, height: size)
                .overlay(
                    Image(systemName: "die.face.\((roll + 1) % die + 1).fill")
                        .resizable()
                        .frame(width: size, height: size)
                        .foregroundColor(.gray)
                        .background(
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: size * 0.75, height: size * 0.75)
                        )
                )
                .overlay(Color.black.opacity(rotation * 0.5))
                .rotation3DEffect(.degrees(rotation * 90), axis: (x: 0, y: 1, z: 0), anchor: .leading, anchorZ: 0, perspective: 1)
                .offset(x: rotation * size)

            Rectangle()
                .fill(Color.gray)
                .frame(width: size, height: size)
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
                .overlay(Color.white.opacity(rotation * -0.5 + 0.5))
                .rotation3DEffect(.degrees(rotation * 90 - 90), axis: (x: 0, y: 1, z: 0), anchor: .trailing, anchorZ: 0, perspective: 1)
                .offset(x: rotation * size - size)
        }
    }
}
