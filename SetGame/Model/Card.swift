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
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
