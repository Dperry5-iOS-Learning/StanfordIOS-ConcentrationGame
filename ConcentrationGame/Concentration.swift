//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by Dylan Perry on 7/1/19.
//  Copyright © 2019 Dylan Perry. All rights reserved.
//

import Foundation
class Concentration
{
    //
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func flipAllCardsFaceDown(){
        for flipDownIndex in cards.indices{
            cards[flipDownIndex].isFaceUp = false
        }
    }
    
    func chooseCard(at index:Int){
        if !cards[index].isMatched {
            // 3 cases:
            // No cards are face up
            // Two Cards are face up (matching or not)
                // If thats true, flip those cards face down
            // One Card Face Up, now we need to test the match
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // Check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else{
                // either No Cards or 2 cards are face up
                // Turn all Cards Facedown
                flipAllCardsFaceDown()
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        // 1 up to and including numberOfPairsOfCards
        // _ means ignore this / I don't care what this is
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // append twice (need to have matches)
            // Passing in struct of card, creates a copy.
            cards += [card, card]
        }
        //TODO: Shuffle the cards
//        cards.shufle()
        cards = cards.shuffled()
    }
    
}
