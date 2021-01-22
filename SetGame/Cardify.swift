//
//  Cardify.swift
//  Memorize
//
//  Created by Richard on 1/20/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var isSelected: Bool = false
    
    @State private var cardOffsetX: CGFloat = 0
    @State private var cardOffsetY: CGFloat = 0
    private func cardFlyAnimation(flyIn: Bool) {
        let randomX = CGFloat.random(in: 200...400) * (Bool.random() ? 1 : -1)
        let randomY = CGFloat.random(in: 200...400) * (Bool.random() ? 1 : -1)
        cardOffsetX = flyIn ? randomX : 0
        cardOffsetY = flyIn ? randomY : 0
        withAnimation(.easeOut(duration: 0.75)) {
            cardOffsetX = flyIn ? 0 : randomX
            cardOffsetY = flyIn ? 0 : randomY
        }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                .shadow(color: isSelected ? .blue : .gray, radius: isSelected ? 8 : 3, x: 0.0, y: isSelected ? 0.0 : 1.0)
            //RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
            /*.ifTrue(isSelected) {
                    AnyView($0.shadow(color: .blue, radius: 8, x: 0.0, y: 1.0))
                }*/
            content
        }
        .offset(x: cardOffsetX, y: cardOffsetY)
        .transition(
            .offset(y: isSelected ? -5 : 0))
            .rotation3DEffect(
                .degrees(isSelected ? -2 : 0),
                axis: (x: 1.0, y: 0.0, z: 0.0)
        )
        .onAppear() {
            cardFlyAnimation(flyIn: true)
        }
        .onDisappear() {
            cardFlyAnimation(flyIn: false)
        }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isSelected: Bool = false) -> some View {
        self.modifier(Cardify(isSelected: isSelected))
    }
    
    func ifTrue(_ condition:Bool, apply:(AnyView) -> (AnyView)) -> AnyView {
        if condition {
            return apply(AnyView(self))
        }
        else {
            return AnyView(self)
        }
    }
}
