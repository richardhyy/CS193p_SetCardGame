//
//  SetGame.swift
//  SetGame
//
//  Created by Richard on 1/22/21.
//

import Foundation

struct SetGame {
    private(set) var score: Int = 0 {
        didSet {
            if score < 0 {
                score = 0
            }
        }
    }
    
    private(set) var cards = [Card]()
    
    private var dealtCardIds: [Int]
    
    var matchedCount: Int {
        var count = 0
        for card in cards {
            if card.isMatched {
               count += 1
            }
        }
        return count
    }
    
    var hiddenCards: Int {
        cards.count - dealtCardIds.count - matchedCount
    }
    
    var dealtCards:[Card] {
        var dealt = [Card]()
        for id in dealtCardIds {
            if let index = cards.firstIndex(id: id) {
                dealt.append(cards[index])
            }
        }
        return dealt
    }
    
    var matchedCards:[Card] {
        var matched = [Card]()
        for index in cards.indices {
            if cards[index].isMatched {
                matched.append(cards[index])
            }
        }
        return matched
    }
    
    var selectedIndex: [Int] {
        var selected = [Int]()
        for index in cards.indices {
            if !cards[index].isMatched && cards[index].isSelected {
                selected.append(index)
            }
        }
        return selected
    }
    
    init() {
        dealtCardIds = [Int]()
        initializeDeck(cardDeck: &cards)
        cards.shuffle()
        
        dealCards(extra: 12)
    }
    
    private func initializeDeck(cardDeck: inout [Card]) {
        cardDeck = [Card]()
        var id = 0
        for number in 1...3 {
            for colorIndex in 0...2 {
                for shapeIndex in 0...2 {
                    for shadingIndex in 0...2 {
                        cardDeck.append(Card(id: id, number: number, shape: Shape(rawValue: shapeIndex)!, shading: Shading(rawValue: shadingIndex)!, color: Color(rawValue: colorIndex)!))
                        id += 1
                    }
                }
            }
        }
    }
    
    func getUnseenCards(amount: Int) -> [Int] {
        var stack = [Int]()
        
        for _ in 1...min(amount, cards.count - matchedCount) {
            findAvailableCard: for card in cards {
                if !card.isMatched && !stack.contains(card.id) && !dealtCardIds.contains(card.id) {
                    stack.append(card.id)
                    break findAvailableCard
                }
            }
        }
        
        return stack
    }
    
    mutating func dealCards(extra: Int) {
        if dealtCardIds.count < 18 {
            for id in getUnseenCards(amount: extra) {
                dealtCardIds.append(id)
            }
        }
    }
    
    func checkSet(for c: [Card]) -> Bool {
        /* A Set satisfies:
         * same/diff shape
         * same/diff color
         * same/diff number
         * same/diff shading
         */
        precondition(c.count == 3, "A Set must contain 3 cards")
        
        let shapePass: Bool =
            (c[0].shape == c[1].shape && c[1].shape == c[2].shape) ||
            (c[0].shape != c[1].shape && c[1].shape != c[2].shape && c[0].shape != c[2].shape)
        let colorPass: Bool =
            (c[0].color == c[1].color && c[1].color == c[2].color) ||
            (c[0].color != c[1].color && c[1].color != c[2].color && c[0].color != c[2].color)
        let numberPass: Bool =
            (c[0].number == c[1].number && c[1].number == c[2].number) ||
            (c[0].number != c[1].number && c[1].number != c[2].number && c[0].number != c[2].number)
        let shadingPass: Bool =
            (c[0].shading == c[1].shading && c[1].shading == c[2].shading) ||
            (c[0].shading != c[1].shading && c[1].shading != c[2].shading && c[0].shading != c[2].shading)
        
        return shapePass && colorPass && numberPass && shadingPass
    }
    
    mutating func select(card: Card) {
        if let index = cards.firstIndex(matching: card) {
            print("Selected card: \(card)")
            
            cards[index].isSelected = !cards[index].isSelected
            
            if cards[index].isSelected {
                checkSet()
            }
        }
    }
    
    mutating func checkSet() {
        let selected: [Int] = selectedIndex
        if selected.count == 3 {
            if checkSet(for: [cards[selected[0]], cards[selected[1]], cards[selected[2]]]) {
                for index in selected {
                    cards[index].isMatched = true
                    let removedAtIndex = dealtCardIds.firstIndex(of: cards[index].id)!
                    dealtCardIds.remove(at: removedAtIndex)
                    
                    let monoStack = getUnseenCards(amount: 1)
                    
                    if monoStack.count == 1 {
                        dealtCardIds.insert(monoStack[0], at: removedAtIndex)
                    }
                }
                score += 1
                
            }
            else {
                for index in selected {
                    cards[index].isSelected = false
                }
                score -= 1
            }
        }
    }
    
    mutating func getHint() {
        if score <= 0 {
            return
        }
        if dealtCardIds.count > 3 {
            var done = false
            
            // deselect all
            for index in selectedIndex {
                cards[index].isSelected = false
            }
            
            for _ in 0...128 {
                let break1 = Int.random(in: 0...dealtCardIds.count-3)
                let break2 = Int.random(in: break1...dealtCardIds.count-2)
                let id1 = 0==break1 ? 0 : Int.random(in: 0..<break1)
                let id2 = break1==break2 ? break1 : Int.random(in: break1..<break2)
                let id3 = break2==dealtCardIds.count-1 ? break2 : Int.random(in: break2...dealtCardIds.count-1)
                
                if checkSet(for: [
                    cards[cards.firstIndex(id: dealtCardIds[id1])!],
                    cards[cards.firstIndex(id: dealtCardIds[id2])!],
                    cards[cards.firstIndex(id: dealtCardIds[id3])!],
                ]) {
                    cards[cards.firstIndex(id: dealtCardIds[id1])!].isSelected = true
                    cards[cards.firstIndex(id: dealtCardIds[id2])!].isSelected = true
                    cards[cards.firstIndex(id: dealtCardIds[id3])!].isSelected = true
                    done = true
                    break
                }
            }
            if !done { // get extra cards since there's probably no match set
                dealCards(extra: 3)
            }
            else {
                score -= 1
            }
        }
    }

    struct Card: Identifiable {
        var id: Int
        
        var number: Int
        var shape: Shape
        var shading: Shading
        var color: Color
        
        var isSelected: Bool = false
        var isMatched: Bool = false
    }

    enum Color: Int {
        case red = 0
        case green = 1
        case purple = 2
    }

    enum Shape: Int {
        case diamond = 0
        case squiggle = 1
        case oval = 2
    }

    enum Shading: Int {
        case open = 0
        case striped = 1
        case solid = 2
    }
}
