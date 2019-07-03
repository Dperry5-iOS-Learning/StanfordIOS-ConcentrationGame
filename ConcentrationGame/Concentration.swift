//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by Dylan Perry on 7/1/19.
//  Copyright © 2019 Dylan Perry. All rights reserved.
//

import Foundation
// Was originally, may be better as a struct.
struct Concentration
{
    //has to be public readable
    // but not settable
    // Anything as a var is writable
    // let is not writable
    private(set) var cards = [Card]()
    
    // mutable because it has the setter
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{ cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    // Have to add mutating because self is used.
    // Value-Types require this kind of mutating declaration.
    // Copy-On-Write Semantics requires this.
    mutating func chooseCard(at index:Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            // 3 cases:
            // No cards are face up
            // Two Cards are face up (matching or not)
                // If thats true, flip those cards face down
            // One Card Face Up, now we need to test the match
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // Check if cards match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
            } else{
                // either No Cards or 2 cards are face up
                // Turn all Cards Facedown
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): You must have at least one pair of cards")
        // 1 up to and including numberOfPairsOfCards
        // _ means ignore this / I don't care what this is
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // append twice (need to have matches)
            // Passing in struct of card, creates a copy.
            cards += [card, card]
        }
        cards = cards.shuffled()
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first: nil
    }
}
