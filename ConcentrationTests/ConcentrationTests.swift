//
//  ConcentrationTests.swift
//  ConcentrationTests
//
//  Created by Vokh Stag on 03/04/2020.
//  Copyright © 2020 Vokh Stag. All rights reserved.
//

import XCTest
@testable import Concentration

class ConcentrationTests: XCTestCase {
    
    var sut: Concentration!

    override func setUp() {
        sut = Concentration(numberOfPairsOfCards: 6)
    }

    override func tearDown() {
        sut = nil
    }
    
    func testConcentration_initial_whenStartedCardsCreated() {
        XCTAssertEqual(sut.cards.count, 12)
    }
    func testConcentration_initial_whenStartedCardsNotIsFaceUpAndNotMatched() {
        // given
        var isSomeCardFaceUp = false
        var isSomeCardMatched = false
        //when
        for index in sut.cards.indices {
            if sut.cards[index].isFaceUp {
                isSomeCardFaceUp = true
            }
            if sut.cards[index].isMached {
                isSomeCardMatched = true
            }
        }
        XCTAssert(!isSomeCardFaceUp)
        XCTAssert(!isSomeCardMatched)
    }
    
    func testConcentration_wnenChooseCard_itIsChoosen() {
        //when
        sut.chooseCard(at: 3)
        
        XCTAssert(sut.cards[3].isFaceUp)
    }
    func testConcentration_whenChossenTwoSameCards_thereAreMatched() {
        //given
        sut = Concentration(numberOfPairsOfCards: 1)
        //when
        sut.chooseCard(at: 0)
        sut.chooseCard(at: 1)
        //then
        XCTAssert(sut.cards[0].isMached)
        XCTAssert(sut.cards[1].isMached)
    }
    func testConcentration_whenChossenTwoDifferentCards_thereAreNotMatched() {
        //given
        let firstIndex = 0
        var indexWithDifferentIdentifier = 0
        for index in sut.cards.indices {
            if sut.cards[index].identifier != sut.cards[firstIndex].identifier {
                indexWithDifferentIdentifier = index
            }
        }
        //when
        sut.chooseCard(at: firstIndex)
        sut.chooseCard(at: indexWithDifferentIdentifier)
        //then
        XCTAssert(!sut.cards[0].isMached)
        XCTAssert(!sut.cards[1].isMached)
    }
    func testConcentration_ifChoosedThreeCards_firstPairOfCardsNotChoosen() {
        // when
        sut.chooseCard(at: 1)
        sut.chooseCard(at: 3)
        sut.chooseCard(at: 0)
        
        //then
        XCTAssert(!sut.cards[1].isFaceUp)
        XCTAssert(!sut.cards[3].isFaceUp)
        
    }
    

}
