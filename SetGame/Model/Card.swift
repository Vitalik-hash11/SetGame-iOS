//
//  Card.swift
//  SetGame
//
//  Created by newbie on 25.03.2022.
//

import Foundation

struct Card {
    var isSelected = false
    var isMatched = false
    var shapeIdentifier: Int
    var colorIdentifier: Int
    var shadingIdentifier: Int
    var countIdentifier: Int
    
    static var uniqueCardsArray = generateUniqueCardsArray()
    
    static func getUniqueIdentifiers() -> (shapeIdentifier: Int, colorIdentifier: Int, shadingIdentifier: Int, countIdentifier: Int) {
        if uniqueCardsArray.isEmpty {
            uniqueCardsArray = generateUniqueCardsArray()
        }
        let uniqueIdentifiers = uniqueCardsArray.removeLast()
        return uniqueIdentifiers
    }
    
    init() {
        self.shapeIdentifier = Card.getUniqueIdentifiers().shapeIdentifier
        self.colorIdentifier = Card.getUniqueIdentifiers().colorIdentifier
        self.shadingIdentifier = Card.getUniqueIdentifiers().shadingIdentifier
        self.countIdentifier = Card.getUniqueIdentifiers().countIdentifier
    }
    
    static func generateUniqueCardsArray() -> [(shapeIdentifier: Int, colorIdentifier: Int, shadingIdentifier: Int, countIdentifier: Int)] {
        var uniqueCardsArray = [(shapeIdentifier: Int, colorIdentifier: Int, shadingIdentifier: Int, countIdentifier: Int)]()
        for shapeIdentifier in 0...2 {
            for colorIdentifier in 0...2 {
                for shadingIdentifier in 0...2 {
                    for countIdentifier in 0...2 {
                        uniqueCardsArray.append((shapeIdentifier, colorIdentifier, shadingIdentifier, countIdentifier))
                    }
                }
            }
        }
        return uniqueCardsArray.shuffled()
    }
}
