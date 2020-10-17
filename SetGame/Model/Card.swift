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

    var matrixWithIntValues: [Int] {
        return [number, color.rawValue, shape.rawValue, shading.rawValue]
    }
    
    enum Color: Int, CaseIterable{
        case blue = 1
        case red
        case green
    }
    
    enum Shape: Int, CaseIterable {
        case circle = 1
        case triangle
        case square
    }
    
    enum Shading: Int, CaseIterable{
        case empty = 1
        case filled
        case stripped
    }
}
