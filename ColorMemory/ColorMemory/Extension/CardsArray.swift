//
//  CardsArray.swift
//  ColorMemory
//
//  Created by Alex Cheung on 26/11/2019.
//  Copyright © 2019 Alex Cheung. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        for _ in 0...self.count {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
