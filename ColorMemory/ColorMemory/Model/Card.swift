//
//  Card.swift
//  ColorMemory
//
//  Created by Alex Cheung on 25/11/2019.
//  Copyright © 2019 Alex Cheung. All rights reserved.
//

import Foundation
import UIKit

class Card {
    var id: Int
    var shown: Bool = false
    var indexPosition: Int
    
    init(id: Int, indexPosition: Int) {
        self.id = id
        self.indexPosition = indexPosition
    }
    
    func compare(_ card: Card) -> Bool {
        return (card.id == id)
    }
    
}


