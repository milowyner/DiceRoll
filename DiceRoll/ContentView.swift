//
//  ContentView.swift
//  DiceRoll
//
//  Created by Milo Wyner on 9/30/21.
//

import SwiftUI

struct ContentView: View {
    private let size: CGFloat = 100
    @State private var number = 0.0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: size, height: size)
                .overlay(Text("1").font(.title).foregroundColor(.white))
                .overlay(Color.black.opacity(number * 0.5))
                .rotation3DEffect(.degrees(number * 90), axis: (x: 0, y: 1, z: 0), anchor: .leading, anchorZ: 0, perspective: 1)
                .offset(x: number * size)
            
            Rectangle()
                .fill(Color.gray)
                .frame(width: size, height: size)
                .overlay(Text("2").font(.title).foregroundColor(.white))
                .overlay(Color.white.opacity(number * -0.5 + 0.5))
                .rotation3DEffect(.degrees(number * 90 - 90), axis: (x: 0, y: 1, z: 0), anchor: .trailing, anchorZ: 0, perspective: 1)
                .offset(x: number * size - size)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                if number == 0 {
                    number = 1
                } else {
                    number = 0
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
