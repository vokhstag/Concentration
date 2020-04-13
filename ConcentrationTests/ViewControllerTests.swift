//
//  ViewControllerTests.swift
//  ConcentrationTests
//
//  Created by Vokh Stag on 12/04/2020.
//  Copyright © 2020 Vokh Stag. All rights reserved.
//

import XCTest
import UIKit
@testable import Concentration


class ViewControllerTests: XCTestCase {
    
    var sut: ViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        sut = vc as? ViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testViewController_whenStarted_cardButtonsNotNil() {
        XCTAssertNotNil(sut.cardButtons)
    }
    
    func testViewController_whenStarted_cardPairsEqualHalfOfCardButtons() {
        XCTAssertEqual(sut.cardButtons.count + 1/2, sut.numberOfPairsOfCards)
    }
    func testViewController_whenStarted_flipCountIsZero() {
        XCTAssertEqual(sut.flipCount, 0)
    }
    func testViewController_whenTouchCard_flipCountIncreases() {
        //when
        sut.touchCard(sut.cardButtons[0])
        
        //then
        XCTAssertEqual(sut.flipCount, 1)
    }
    func testViewController_whenTouchCard_cardIsChoosen() {
        //when
        sut.touchCard(sut.cardButtons[0])
        //then
        XCTAssertEqual(sut.cardButtons[0].backgroundColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    func testViewController_whenTouchCard_cardSetEmoji() {
        //when
        sut.touchCard(sut.cardButtons[0])
        //then
        XCTAssert(!sut.cardButtons[0].title(for: .normal)!.isEmpty)
    }
    
    func testViewController_whenTouchNewGame_AllCardsNotChoosenAndNotMatched() {
        //given
        sut.touchCard(sut.cardButtons[0])
        sut.touchCard(sut.cardButtons[1])
        sut.newGame()
        //when
        var numberOfChoosenCards = 0
        var numberOfMachedCards = 0
        
        for index in sut.game.cards.indices {
            if sut.game.cards[index].isFaceUp {
                numberOfChoosenCards += 1
            }
            if sut.game.cards[index].isMached {
                numberOfMachedCards += 1
            }
        }
        //then
        XCTAssertEqual(numberOfChoosenCards, 0)
        XCTAssertEqual(numberOfMachedCards, 0)
        
    }
}
