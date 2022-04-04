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
        let (shapeIdentifier, colorIdentifier, shadingIdentifier, countIdentifier) = Card.getUniqueIdentifiers()
        self.shapeIdentifier = shapeIdentifier
        self.colorIdentifier = colorIdentifier
        self.shadingIdentifier = shadingIdentifier
        self.countIdentifier = countIdentifier
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
    
    subscript(property: String) -> Int {
        switch property {
        case "shapeIdentifier":
            return shapeIdentifier
        case "colorIdentifier":
            return colorIdentifier
        case "shadingIdentifier":
            return shadingIdentifier
        case "countIdentifier":
            return countIdentifier
        default:
            fatalError("Cannot find property \(property) in Card struct")
        }
    }
}

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return
            lhs.colorIdentifier == rhs.colorIdentifier &&
            lhs.countIdentifier == rhs.countIdentifier &&
            lhs.shadingIdentifier == rhs.shadingIdentifier &&
            lhs.shapeIdentifier == rhs.shapeIdentifier
    }
}
