//
//  DieView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/4/21.
//

import SwiftUI

struct DieView: View {
    let sides: Int
    @State private var rotation = 0.0
    @State private var array: [Int]
    private let size: CGFloat = 100
    
    init(sides: Int) {
        self.sides = sides
        array = [Int](1...sides).shuffled()
    }
    
    private struct SideLabel: AnimatableModifier {
        let sides: Int
        var rotation: Double
        let array: [Int]
        let size: CGFloat
        var offset: Bool = false
        
        var animatableData: Double {
            get { rotation }
            set { rotation = newValue }
        }
        
        private var roll: Int {
            return array[Int(rotation * 15.5 + (offset ? 1 : 0)) % sides]
        }
        
        func body(content: Content) -> some View {
            if sides <= 6 {
                content.overlay(
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
            } else {
                content.overlay(
                    Text("\(roll)")
                        .font(.system(size: 60))
                        .minimumScaleFactor(0.5)
                        .allowsTightening(true)
                        .foregroundColor(.white)
                        .padding(8)
                        .animation(nil)
                )
            }
        }
    }
    
    func sideView(offset: Bool = false) -> some View {
        Rectangle()
            .fill(Color.gray)
            .frame(width: size, height: size)
            .modifier(SideLabel(sides: sides, rotation: rotation, array: array, size: size, offset: offset))
            .animation(rotation == 0 ? nil : .easeOut(duration: 2))
            .overlay(
                (offset ? Color.black : Color.white)
                    .opacity(rotation * (offset ? 1 : -1) * 0.5 + (offset ? 0 : 0.5))
            )
            .rotation3DEffect(
                .degrees(rotation * 90 - (offset ? 0 : 90)),
                axis: (x: 0, y: 1, z: 0),
                anchor: offset ? .leading : .trailing,
                anchorZ: 0, perspective: 1
            )
            .offset(x: rotation * size - (offset ? 0 : size))
            .animation(rotation == 0 ? nil : .easeInOut(duration: 2))
    }
    
    var body: some View {
//        NavigationView {
            ZStack {
                sideView(offset: true)
                sideView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                array.shuffle()
                rotation = 0
                withAnimation {
                    rotation = 1
                }
            }
            .navigationTitle("Dice Roll")
//        }
    }
}

struct DieView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
