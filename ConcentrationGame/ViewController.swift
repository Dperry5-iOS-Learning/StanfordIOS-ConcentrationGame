//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Dylan Perry on 6/28/19.
//  Copyright © 2019 Dylan Perry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Does not get initialized until its referenced
    // Cannot use property observervers like didSet
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2);
    // Property == Instant Variable
    // Must be initialized
    // Type Inference (no decimal, so its an int
    var flipCount = 0 {
        didSet {
          flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiChoices = ["🎃", "🍭", "🍫", "🍬","👻","🦇", "😈","🍎","🙀" ]
    var currentEmojiChoices = [String]()

    // TODO Add Button to restart game.
    
    @IBAction func newGamePressed(_ sender: Any) {
        currentEmojiChoices = emojiChoices
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        game.flipAllCardsFaceDown()
        updateViewFromModel()
        flipCount = 0;
        
    }
    //! is important, but we'll come back to it later
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEmojiChoices = emojiChoices
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        // Return value of an Optional Int
        // Optional has 2 states: Set and NotSet
        // ! = Assume  optional is set, and grab associated value, if optional isn't set, and ! is used, the program will crash
        // Use If to protect us from crtash
        flipCount += 1
        if let cardIndex = cardButtons.firstIndex(of:sender) {
            print("CardNumber = \(cardIndex)")
            // "External names used below"
//            flipCard(withEmoji: emojiChoices[cardIndex], on: sender);
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        } else{
            print("Chosen card not in card button")
        }
        
      
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for:card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else {
                button.setTitle("", for: UIControl.State.normal)
                // type in color
                // set color literal
                button.backgroundColor = card.isMatched ?#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.6172243953, blue: 0, alpha: 1)
            }
        }
    }
    
 
    
    //Declarations of Dictionaries
    //var emoji = Dictionary<Int, String>()
    var emoji = [Int:String]()
    func emoji(for card: Card) -> String {
        // Could do this...
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]
//        }else{
//            return "?"
//        }
        // Same as commented out if/elseabove
        if emoji[card.identifier] == nil, currentEmojiChoices.count > 0{
                emoji[card.identifier] = currentEmojiChoices.remove(at: Int(arc4random_uniform(UInt32(currentEmojiChoices.count))))
        }
        return emoji[card.identifier] ?? "?"
        
    }
}

