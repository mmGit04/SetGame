//
//  Card.swift
//  SetGame
//
//  Created by Mina Milosavljevic on 5/23/20.
//  Copyright © 2020 Mina Milosavljevic. All rights reserved.
//

import Foundation

struct Card {
    let shape: Shape
    let shading: Shading
    let number: Int
    let color: Color
    
    enum Color: Equatable, CaseIterable{
        case blue
        case red
        case green
    }
    
    enum Shape : String, Equatable, CaseIterable {
        case circle = "●"
        case triangle = "◼︎"
        case square = "▲"
    }
    
    enum Shading :Equatable, CaseIterable{
        case empty
        case filled
        case stripped
        
    }
}


