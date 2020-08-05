//
//  SetGame.swift
//  SetGame
//
//  Created by Mina Milosavljevic on 5/23/20.
//  Copyright © 2020 Mina Milosavljevic. All rights reserved.
//

import Foundation

class SetGame{
    // Ovde su svih 81 kartica 
    private var cards = [Card]()
    // Na odredjenom indexu se nalazi neka kartica, na osnovu indexa dohvatam karticu
    // Ako je displayedCard[i]=nil onda taj button ne prikazujem
    private(set) var displayedCards = [Card?]()
    private(set) var selectedCards = [Int]()
    
    // Indicates which lining does the cards in SelectedCards shoudl have
    // 1. Green -> Matched
    // 2. Blue -> Selected
    // 3. Red -> Didn't match
    private(set) var setMatched: Bool?

    // Ovo je dobro primenjeno je ono sto je on radio na demou.
    init() {
        for number in 1...3 {
            for shape in Card.Shape.allCases {
                for color in Card.Color.allCases {
                    for shading in Card.Shading.allCases {
                        let card = Card(shape: shape, shading: shading, number: number, color: color)
                        cards.append(card)
                    }
                }
            }
            
        }
        cards.shuffle()
        // Inicijalizacija prikazanih kartca
        for i in 0..<24 {
            if i < 12 {
                displayedCards.append(cards.remove(at: i))
            } else {
                displayedCards.append(nil)
            }
            
        }
    }
    
    func addThreeMoreCards() {
        var iter = 0
        if cards.count > 0 {
            for i in displayedCards.indices {
                if displayedCards[i] == nil, iter < 3 {
                    let card = cards.removeFirst()
                        displayedCards[i] = card
                        iter += 1
                    
                }
            }
        }
            
    }
    
    
    func selectCard(cardIndex: Int) {
        if !selectedCards.contains(cardIndex) {
            //selection
            // 1. adding if less then 3 is selected
            if selectedCards.count < 2 {
                selectedCards.append(cardIndex)
                // Ako je treca dodata onda radimo checking seta
            } else {
                // Ovde upadatamo ako smo upravo selektovali 3 karte
                // Ovde imamo 2 case: kada smo selektovali 4 ili kada smo selektovali 3,
                if selectedCards.count == 3 {
                    // selektujemo 4. ovde treba deselktujemo i da dodamo nove karte
                    if let matched = setMatched, matched {
                        displayedCards[selectedCards[0]] = nil
                        displayedCards[selectedCards[1]] = nil
                        displayedCards[selectedCards[2]] = nil
                        addThreeMoreCards()
                    }
                    // Case kada je 4. koju selektujemo jedna od 3 matched nije pokriven.
                    setMatched = nil
                    selectedCards.removeAll()
                    selectedCards.append(cardIndex)
                    
                } else {
                    // Set checking
                    selectedCards.append(cardIndex)
                    setMatched = checkSet()
                }
            }
            
        } else if selectedCards.count < 3 {
            //deselection and less then 3 card is selected
            selectedCards.remove(at: selectedCards.firstIndex(of: cardIndex)!)
        }
    }
    
    private func checkSet() -> Bool {
        
        let cardOne = displayedCards[selectedCards[0]]!
        let cardTwo = displayedCards[selectedCards[1]]!
        let cardThree = displayedCards[selectedCards[2]]!
        
        // Shape
        
        return Card.isSet(cardOne: cardOne, cardTwo: cardTwo, cardThree: cardThree)
    }
}

extension Card {
    static func isSet(cardOne: Card, cardTwo: Card, cardThree: Card) -> Bool {
        var shapeCondition = false
        let colorCondition = true
        let numberCondition = true
        let shadingCondition = true
        
        if ((cardOne.shape == cardTwo.shape) && (cardThree.shape == cardOne.shape)) ||
            ((cardOne.shape != cardTwo.shape) && (cardTwo.shape != cardThree.shape) && (cardThree.shape != cardOne.shape))
        {
            shapeCondition = true
        } else {
            shapeCondition = false
        }
        // For every condition we should do the same. Needs some optimization
        
        return shapeCondition && colorCondition && numberCondition && shadingCondition
    }
}

