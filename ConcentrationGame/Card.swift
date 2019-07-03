//
//  Card.swift
//  ConcentrationGame
//
//  Created by Dylan Perry on 7/1/19.
//  Copyright © 2019 Dylan Perry. All rights reserved.
//

import Foundation

//Why Struct instead of class?
// Structs have no inheritance -- a little bit simpler
// Structs are valueTypes and Classes are Reference Types
// ValueType => When you pass it as an argument, it gets copied.
// Copy-On-Write Semantics
//Reference Types => Things lives in Heap, has pointers to it, you're passing pointers to it around.
struct Card: Hashable
{
    // UI Independent so no emojis.
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    // Synthesized by compiler
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }
    
    
    static func ==(lhs:Card, rhs:Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    // Default implementation from protocol extension
    var hashValue: Int {
        var hasher = Hasher()
        self.hash(into: &hasher)
        return hasher.finalize()
    }
    
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
