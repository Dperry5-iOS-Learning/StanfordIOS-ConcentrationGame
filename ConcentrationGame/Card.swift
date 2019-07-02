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
struct Card
{
    // UI Independent so no emojis.
    var isFaceUp = false
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
