//
//  Set.swift
//  SetGame
//
//  Created by newbie on 26.03.2022.
//

import Foundation

class SetGame {
    
    // MARK: - Initializers
    
    init() {
        for _ in 1...12 { // Only 12 cards will be shown at the start of the game
            self.playedCards += [Card()]
        }
        for _ in 1...69 { // The full deck is 81 cards after first hand become 69 (81 - 12)
            self.cardsDeck += [Card()]
        }
    }
    
    // MARK: - Public API
    
    var score = 0
    
    var playedCards = [Card]()
    
    var cardsDeck = [Card]()
    
    var selectedCards = [Card]()
    
    var alreadyMatched = [Card]()
    
    var isCurrentlySelectedCardsMatch = false
    
    
    func selectCard(at index: Int) {
        if !playedCards[index].isSelected {
            if selectedCards.count == 3 {
                clearSelected()
                playedCards[index].isSelected = true
                selectedCards.append(playedCards[index])
            } else if selectedCards.count == 2 {
                playedCards[index].isSelected = true
                selectedCards.append(playedCards[index])
                checkMatch()
            } else {
                playedCards[index].isSelected = true
                selectedCards.append(playedCards[index])
            }
        } else {
            if selectedCards.count < 3 {
                guard let selectedCardIndex = selectedCards.firstIndex(of: playedCards[index]) else { fatalError() }
                selectedCards.remove(at: selectedCardIndex)
                playedCards[index].isSelected = false
                score -= 1
            }
        }
    }
    
    func addThreeMoreCards() {
        if selectedCards.count == 3 {
            clearSelected()
        }
        for _ in 1...3 {
            playedCards.append(cardsDeck.removeLast())
        }
    }
    
    // MARK: - private methods
    
    private func checkMatch() {
        if compareByAttribute("shapeIdentifier", first: selectedCards[0], second: selectedCards[1], third: selectedCards[2]),
           compareByAttribute("colorIdentifier", first: selectedCards[0], second: selectedCards[1], third: selectedCards[2]),
           compareByAttribute("shadingIdentifier", first: selectedCards[0], second: selectedCards[1], third: selectedCards[2]),
           compareByAttribute("countIdentifier", first: selectedCards[0], second: selectedCards[1], third: selectedCards[2])
        {
            isCurrentlySelectedCardsMatch = true
            score += 3
        } else {
            isCurrentlySelectedCardsMatch = false
            score -= 5
        }
    }
    
    private func compareByAttribute(_ attribute: String, first: Card, second: Card, third: Card) -> Bool {
        if (first[attribute] == second[attribute] &&            // attribute should be equal in all cards
            first[attribute] == third[attribute] &&             // or different
            second[attribute] == third[attribute]) ||
            (first[attribute] != second[attribute] &&
             first[attribute] != third[attribute] &&
             second[attribute] != third[attribute]) {
            return true
        } else {
            return false
        }
    }
    
    private func clearSelected() {
        if isCurrentlySelectedCardsMatch {
            for index in selectedCards.indices {
                guard let playedCardIndex = playedCards.firstIndex(of: selectedCards[index]) else {
                    fatalError()
                }
                alreadyMatched.append(playedCards.remove(at: playedCardIndex))
            }
            if playedCards.count < 12 {
                for _ in 1...3 {
                    playedCards.append(cardsDeck.removeLast())
                }
            }
            selectedCards.removeAll()
            isCurrentlySelectedCardsMatch = false
        } else {
            for index in playedCards.indices {
                playedCards[index].isSelected = false
            }
            selectedCards.removeAll()
        }
    }
}
