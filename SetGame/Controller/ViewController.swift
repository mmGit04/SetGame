//
//  ViewController.swift
//  SetGame
//
//  Created by Mina Milosavljevic on 5/23/20.
//  Copyright © 2020 Mina Milosavljevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var game = SetGame()
    
    @IBAction func newGame(_ sender: UIButton) {
        
    }
    private var numberOfFreeSlots: Int {
        get {
            var value = 0
            for i in cardButtons.indices {
                if cardButtons[i].isHidden {
                    value += 1
                }
            }
            return value
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in cardButtons.indices {
            let button = cardButtons[i]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        }
        updateUI()
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func dealThreeMore(_ sender: UIButton) {
        game.addThreeMoreCards()
        updateUI()
    }
    
    
    @IBAction func selectCard(_ sender: UIButton) {
        let selectedIndex = cardButtons.firstIndex(of: sender)!
        game.selectCard(cardIndex: selectedIndex)
        updateUI()
    }
    
    
    func updateUI() {
        for index in 0..<cardButtons.count {
            if let cardForButton = game.displayedCards[index] {
                let attributes: [NSAttributedString.Key :Any]  = [
                    .foregroundColor: getColor(color: cardForButton.color, shade: cardForButton.shading)
                    
                ]
                cardButtons[index].setAttributedTitle(NSAttributedString(string: getSymbol(shape: cardForButton.shape, number: cardForButton.number), attributes: attributes), for: UIControl.State.normal)
                cardButtons[index].layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                cardButtons[index].isHidden = false
            } else {
                cardButtons[index].isHidden = true
                
            }
        }
        
        for i in game.selectedCards {
            let button = cardButtons[i]
            if let value = game.setMatched {
                if value {
                    //Matched
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.green.cgColor
                } else {
                    //Not matched
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.red.cgColor
                }
            } else {
                // Selected
                button.layer.borderWidth = 3.0
                button.layer.borderColor = UIColor.blue.cgColor
            }
        }
    }
    func initUI() {
        for i in cardButtons.indices {
            if i < 12 {
                cardButtons[i].isHidden = false
            } else {
                cardButtons[i].isHidden = true
            }
            
        }
    }
}

extension ViewController {
    func getColor(color: Card.Color, shade: Card.Shading) -> UIColor {
        var finalColor: UIColor
        switch color {
        case .blue: finalColor = UIColor.blue
        case .green: finalColor = UIColor.green
        case .red: finalColor = UIColor.red
        }
        switch shade {
        case .empty: finalColor = finalColor.withAlphaComponent(0.1)
        case .stripped: finalColor = finalColor.withAlphaComponent(0.5)
        case .filled: finalColor = finalColor.withAlphaComponent(1)
        }
        return finalColor
    }

    func getSymbol(shape: Card.Shape, number: Int) -> String {
        let symbol:String
        switch shape {
        case .circle: symbol = "●"
        case .square: symbol =  "◼︎"
        case .triangle: symbol = "▲"
        }
        var retValue = symbol
        for _ in 1..<number {
            retValue += symbol
        }
        return retValue
    }
    
}


