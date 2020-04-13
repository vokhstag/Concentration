//
//  Concentration.swift
//  Concentration
//
//  Created by Vokh Stag on 04/04/2020.
//  Copyright © 2020 Vokh Stag. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceupCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int ) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): choosen index not is the cards")
        if !cards[index].isMached {
            if let matchIndex = indexOfOneAndOnlyFaceupCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMached = true
                    cards[index].isMached = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceupCard = index
            }
            
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of card")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
    }
}
