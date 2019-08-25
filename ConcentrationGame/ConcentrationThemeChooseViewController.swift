//
//  ConcentrationThemeChooseViewController.swift
//  ConcentrationGame
//
//  Created by Dylan Perry on 8/17/19.
//  Copyright © 2019 Dylan Perry. All rights reserved.
//

import UIKit

class ConcentrationThemeChooseViewController: UIViewController, UISplitViewControllerDelegate {

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 
     
     
     
 */
    
    let themes = [
        "Sports": ["🥍","🥎","🏎","⚽︎","⚾️","🏒","🏈","🏀"],
        "Animals": ["🦝","🦙","🦛","🦘","🦡","🦚","🦢","🦜","🦞"],
        "Faces":["😀", "😂", "😇", "😍", "🙃", "😎", "🥳", "😱"],
        "Halloween":  ["🎃", "🍭", "🍫", "🍬","👻","🦇", "😈","🍎","🙀" ]
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        
        return false
    }
    
    // Segue from code
    // Halloween Segue here just updates theme - DOES NOT actually "segue"
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            cvc.theme = themes["Halloween"]
        } else if let cvc = lastSeguedToConcentrationViewController {
            cvc.theme = themes["Halloween"]
            navigationController?.pushViewController(cvc, animated: true)
        } else{
            performSegue(withIdentifier: "Choose Theme Halloween", sender: sender)
        }
        
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        } else if segue.identifier == "Choose Theme Halloween" {
            if let cvc = segue.destination as? ConcentrationViewController {
                cvc.theme = themes["Halloween"]
                lastSeguedToConcentrationViewController = cvc
            }
        }
    }

}
