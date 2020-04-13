//
//  ViewController.swift
//  Concentration
//
//  Created by Vokh Stag on 03/04/2020.
//  Copyright © 2020 Vokh Stag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private(set) lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return cardButtons.count + 1/2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    private var emojiChoises = ["👻", "🤡", "☃️", "🥶", "🤖", "🎃", "🧞‍♂️"]
    
    private var emoji = [Int: String]()
    
    @IBOutlet private(set) var cardButtons: [UIButton]!
    
    @IBOutlet weak private var flipCountLabel: UILabel!

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Choosen card is not in cardButtons")
        }
    }
    
    @IBAction func newGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMached ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoises.count > 0 {
            emoji[card.identifier] = emojiChoises.remove(at: emojiChoises.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
    
}

