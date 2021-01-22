//
//  CardView.swift
//  SetGame
//
//  Created by Richard on 1/22/21.
//

import SwiftUI

struct CardView: View {
    var card: SetGame.Card
    
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
        
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        let color: Color = card.color == SetGame.Color.green ? .green : (card.color == SetGame.Color.purple ? .purple : .red)
        let pattern: ImagePaint = ImagePaint(image: Image(decorative: CGImage.stripes(colors: (UIColor.white, UIColor(color)), width: 2.5, ratio: 6), scale: 1))
        
        VStack(spacing: 5) {
            ForEach(0..<card.number) { _ in
                if card.shape == SetGame.Shape.diamond {
                    if card.shading == SetGame.Shading.open {
                        Diamond()
                            .stroke(color, lineWidth: shapeBorderWidth)
                    }
                    else if card.shading == SetGame.Shading.striped {
                        Diamond()
                            .stroke(color, lineWidth: shapeBorderWidth)
                            .background(
                                Diamond()
                                    .fill(pattern)//.border(color, width: stripeWidth)
                            )
                    }
                    else {
                        Diamond()
                    }
                }
                else if card.shape == SetGame.Shape.oval {
                    Group {
                        if card.shading == SetGame.Shading.open {
                            Capsule()
                                .stroke(color, lineWidth: shapeBorderWidth)
                                .aspectRatio(2, contentMode: .fit)
                        }
                        else if card.shading == SetGame.Shading.striped {
                            Capsule()
                                .stroke(color, lineWidth: shapeBorderWidth)
                                .background(
                                    Capsule()
                                        .fill(pattern)//.border(color, width: stripeWidth)
                                )
                                .aspectRatio(2, contentMode: .fit)
                        }
                        else {
                            Capsule()
                                .aspectRatio(2, contentMode: .fit)
                        }
                    }
                }
                else if card.shape == SetGame.Shape.squiggle {
                    if card.shading == SetGame.Shading.open {
                        Squiggle()
                            .stroke(color, lineWidth: shapeBorderWidth)
                            .aspectRatio(2, contentMode: .fit)
                    }
                    else if card.shading == SetGame.Shading.striped {
                        Squiggle()
                            .stroke(color, lineWidth: shapeBorderWidth)
                            .background(
                                Squiggle()
                                    .fill(pattern)//.border(color, width: stripeWidth)
                            )
                            .aspectRatio(2, contentMode: .fit)
                    }
                    else {
                        Squiggle()
                            .aspectRatio(2, contentMode: .fit)
                    }
                }
                else {
                    Text("?")
                }
            }
        }
        .padding(.horizontal, size.width * 0.1)
        .padding(.vertical, size.height * 0.2)
        .foregroundColor(color)
        .cardify(isSelected: card.isSelected)
        .aspectRatio(3/4, contentMode: .fit)
        .padding()
    }
    
    // MARK: - UI Constants
    let shapeBorderWidth: CGFloat = 4
    let stripeWidth: CGFloat = 2
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SetGameViewModel()
        return Grid(viewModel.dealtCards) { card in
            CardView(card: card)
            /*CardView(card: SetGame.Card(id: 0, number: 2, shape: .diamond, shading: .striped, color: .purple, isSelected: true))
            CardView(card: SetGame.Card(id: 0, number: 2, shape: .diamond, shading: .striped, color: .purple, isSelected: true))
            CardView(card: SetGame.Card(id: 1, number: 3, shape: .oval, shading: .striped, color: .green, isSelected: false))*/
        }
    }
}
