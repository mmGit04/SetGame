//
//  SetGame.swift
//  SetGame
//
//  Created by Mina Milosavljevic on 5/23/20.
//  Copyright © 2020 Mina Milosavljevic. All rights reserved.
//

import Foundation

class SetGame{
    
    private var cards = [Card]()
    private(set) var displayedCards = [Card?]()
    private(set) var selectedCards = [Int]()
    
    // Indicates which lining does the cards in SelectedCards should have
    // 1. Green -> Matched
    // 2. Blue -> Selected
    // 3. Red -> Didn't match
    private(set) var setMatched: Bool?
    
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
        // initialize displayed cards
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
            // select a first/second card
            if selectedCards.count < 2 {
                selectedCards.append(cardIndex)
            } else {
                // select a fourth card
                if selectedCards.count == 3 {
                    if let matched = setMatched, matched {
                        displayedCards[selectedCards[0]] = nil
                        displayedCards[selectedCards[1]] = nil
                        displayedCards[selectedCards[2]] = nil
                        addThreeMoreCards()
                    }
                    setMatched = nil
                    selectedCards.removeAll()
                    selectedCards.append(cardIndex)
                } else {
                    // select third card
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
        
        return Card.isSet(cards: [cardOne, cardTwo, cardThree])
    }
}

extension Card {
    
    static func isSet (cards: [Card]) -> Bool {
        guard cards.count == 3 else { return false }
        var sumMatrix = [Int] (repeating: 0, count: 4)
        for card in cards {
            let matrix = card.matrixWithIntValues
            for i in matrix.indices {
                sumMatrix[i] += matrix[i]
            }
        }
        return sumMatrix.reduce(true, { $0 && ($1 % 3 == 0) })
    }
}

