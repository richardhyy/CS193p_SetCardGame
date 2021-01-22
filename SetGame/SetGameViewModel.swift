//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Richard on 1/22/21.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private(set) var game: SetGame = SetGameViewModel.createGame()
    
    static func createGame() -> SetGame {
        return SetGame()
    }
    
    // MARK: - Access to the model
    var dealtCards: [SetGame.Card] {
        game.dealtCards
    }
    
    // MARK: - Intent
    func select(card: SetGame.Card) {
        game.select(card: card)
    }
    
    func dealThreeMore() {
        game.dealCards(extra: 3)
    }
    
    func resetGame() {
        game = SetGameViewModel.createGame()
    }
    
    func getHint() {
        game.getHint()
    }
}
