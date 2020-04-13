//
//  Card.swift
//  Concentration
//
//  Created by Vokh Stag on 04/04/2020.
//  Copyright © 2020 Vokh Stag. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMached = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
