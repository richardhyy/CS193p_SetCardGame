//
//  ContentView.swift
//  SetGame
//
//  Created by Richard on 1/21/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Score: \(viewModel.game.score)")
                Spacer()
                Button("Hint") {
                    viewModel.getHint()
                }
                .padding(.trailing, 10)
                Button("New Game") {
                    viewModel.resetGame()
                }
            }
            Group {
                Spacer()
                Grid(viewModel.dealtCards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.linear(duration: 0.1)) {
                            viewModel.select(card: card)
                        }
                    }
                }
                Spacer()
            }
            .animation(.easeOut(duration: 0.7))
            HStack {
                Text("\(viewModel.game.cards.count - viewModel.game.dealtCards.count - viewModel.game.matchedCount) in Deck")
                Spacer()
                Button("Deal 3 More Cards") {
                    viewModel.dealThreeMore()
                }.padding(.trailing, 60)
                Spacer()
            }
        }
        .padding()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SetGameViewModel())
    }
}
