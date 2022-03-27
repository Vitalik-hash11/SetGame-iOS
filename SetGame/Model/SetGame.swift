//
//  Set.swift
//  SetGame
//
//  Created by newbie on 26.03.2022.
//

import Foundation

class SetGame {
    
    //MARK: - Initializers

    init() {
        for _ in 1...12 { // Only 12 cards will be shown at the start of the game
            self.playedCards += [Card()]
        }
        for _ in 1...69 { // The full deck is 81 cards after first hand become 69 (81 - 12)
            self.cardsDeck += [Card()]
        }
    }
    
    //MARK: - Public API

    var playedCards = [Card]()
    
    var cardsDeck = [Card]()
    
    var selectedCards = [Card]()
    
    var alreadyMatched = [Card]()
    
    var isCurrentlySelectedCardsMatch = false
    
    
    func selectCard(at index: Int) {
        // TODO: Handle card selection
    }
    
    func addThreeMoreCards() {
        for _ in 1...3 {
            playedCards.append(cardsDeck.removeLast())
        }
    }
    
}
