//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Dylan Perry on 6/28/19.
//  Copyright © 2019 Dylan Perry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Property == Instant Variable
    // Must be initialized
    // Type Inference (no decimal, so its an int
    var flipCount = 0 {
        didSet {
          flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    //! is important, but we'll come back to it later
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["👻","🎃","👻", "🎃"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        // Return value of an Optional Int
        // Optional has 2 states: Set and NotSet
        // ! = Assume  optional is set, and grab associated value, if optional isn't set, and ! is used, the program will crash
        // Use If to protect us from crtash
        if let cardIndex = cardButtons.firstIndex(of:sender) {
            print("CardNumber = \(cardIndex)")
            // "External names used below"
            flipCard(withEmoji: emojiChoices[cardIndex], on: sender);
        } else{
            print("Chosen card not in card button")
        }
        
      
    }
    
    // On Last page of Reading 1 (How to pick good names)
    // When someone calls this function it should read like english.
    func flipCard(withEmoji emoji: String, on button:UIButton){
        flipCount += 1
     
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            // type in color
            // set color literal
            button.backgroundColor = #colorLiteral(red: 1, green: 0.6172243953, blue: 0, alpha: 1)
        } else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        }
    }
}

