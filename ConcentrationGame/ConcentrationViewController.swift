//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Dylan Perry on 6/28/19.
//  Copyright © 2019 Dylan Perry. All rights reserved.
//

import UIKit

class ConcentrationViewController: ViewControllerLifecycleLoggingViewController {

    // Does not get initialized until its referenced
    // Cannot use property observervers like didSet
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards);
    
    // computed property
    // should not be settable, but its not settable anyway
    
    override var vclLoggingName: String {
        return "Game"
    }
    
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    // Property == Instant Variable
    // Must be initialized
    // Type Inference (no decimal, so its an int
    // Initialization does NOT invoke didSet
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    
    private func updateFlipCountLabel(){
        // Add some outline and cool ness
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        if game.isGameOver {
            let attributedString = NSAttributedString(string: "You Win!: \(game.score)", attributes: attributes)
            flipCountLabel.attributedText = attributedString

        } else {
            let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
            flipCountLabel.attributedText = attributedString
        }
       
    }
    
    var theme: [String]? {
        didSet {
            emojiChoices = theme!
            currentEmojiChoices = theme!
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    
    
    private var emojiChoices = ["🎃", "🍭", "🍫", "🍬","👻","🦇", "😈","🍎","🙀" ]
    
    
    
    private var currentEmojiChoices = [String]()
    
    private var emoji = [Card:String]()

    //! is important, but we'll come back to it later
    // Updates on firstConnect here.
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currentEmojiChoices = emojiChoices
        // Do any additional setup after loading the view.
    }
    
    
    // TODO Add Button to restart game.
    
    @IBAction private func newGamePressed(_ sender: Any) {
        currentEmojiChoices = emojiChoices
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
        emoji = [Card:String]()

        flipCount = 0;
    }

    
    @IBAction private func touchCard(_ sender: UIButton) {
        // Return value of an Optional Int
        // Optional has 2 states: Set and NotSet
        // ! = Assume  optional is set, and grab associated value, if optional isn't set, and ! is used, the program will crash
        // Use If to protect us from crtash
        flipCount += 1
        if let cardIndex = cardButtons.firstIndex(of:sender) {
//            print("CardNumber = \(cardIndex)")
            // "External names used below"
//            flipCard(withEmoji: emojiChoices[cardIndex], on: sender);
            game.chooseCard(at: cardIndex)
            
            updateFlipCountLabel()

            updateViewFromModel()
        } else{
            print("Chosen card not in card button")
        }
        
      
    }
    
    private func updateViewFromModel(){
        
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for:card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                }else {
                    button.setTitle("", for: UIControl.State.normal)
                    // type in color
                    // set color literal
                    button.backgroundColor = card.isMatched ?#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 1, blue: 0.6151773334, alpha: 1)
                }
            }
        }
        
    }
    
 
    
    //Declarations of Dictionaries
    //var emoji = Dictionary<Int, String>()
    private func emoji(for card: Card) -> String {
        // Could do this...
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]
//        }else{
//            return "?"
//        }
        // Same as commented out if/elseabove
        if emoji[card] == nil, currentEmojiChoices.count > 0{
            emoji[card] = currentEmojiChoices.remove(at:currentEmojiChoices.count.arc4Random)
        }
        return emoji[card] ?? "?"
        
    }
}

//Extended Into to get a random number

extension Int {
    var arc4Random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else{
            return 0
        }
    }
}

